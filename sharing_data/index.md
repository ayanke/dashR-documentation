---
url: /sharing-data-between-callbacks
name: Part 4. Sharing Data Between Callbacks
description:
  "Global variables will break your Dash apps. However, there are other ways to share data between callbacks.
  This chapter is useful for callbacks that run expensive data processing tasks or process large data."
icon: share.svg
languages:
  - python
  - r
---

# ![](/assets/images/language_icons/r-lang_50px.svg) Sharing Data Between Callbacks

> This is the final chapter of the essential [Dash Fundamentals](/).
> The [previous chapter](/interactive-graphing) covered how to use callbacks
> with the dcc.Graph component. The [rest of the Dash
> documentation](/) covers other topics like multi-page apps and component
> libraries. Just getting started? Make sure to [install the necessary
> dependencies](/installation).

One of the core Dash principles explained in the [Getting Started Guide on Callbacks](/basic-callbacks) is that **Dash Callbacks must never modify variables outside of their scope**. It is not safe to modify any global variables. This chapter explains why and provides some alternative patterns for
sharing state between callbacks.

## Why Share State?

In some apps, you may have multiple callbacks that depend on expensive data
processing tasks like making database queries, running simulations, or downloading data.

Rather than have each callback run the same expensive task,
you can have one callback run the task and then share the results to the other callbacks.

One way to achieve this is by having [multiple outputs](/basic-callbacks)
for one callback: the expensive task can be done once and immediately used in all the
outputs. For example, if some data needs to be queried from a database and then displayed in
both a graph and a table, then you can have one callback that calculates the data and creates
both the graph and the table outputs.

But sometimes having multiple outputs in one callback isn't a good solution. For example, suppose
your Dash app allows a user to select a date and a temperature unit (Fahrenheit or Celcius), and
then displays the temperature for that day. You could have one callback that outputs the temperature
by taking both the date and the temperature unit as inputs, but this means that if the user
merely changes from Fahrenheit to Celcius then the weather data would have to be re-downloaded, which
can be time consuming. Instead, it can be more efficient to have two callbacks: one callback that
fetches the weather data, and another callback that outputs the temperature based on the downloaded data.
This way, when only the unit is changed, the data does not have to be downloaded again. This is an
example of **sharing** a variable, or state, between callbacks.

## Dash is Stateless

Dash was designed to be a **stateless** framework.

Stateless frameworks are more scalable and robust than stateful ones. Most websites that you visit are
running on stateless servers.

They are more scalable because it's trivial to add more compute power to the application.
In order to scale the application to serve more users or run more computations,
run more "copies" of the app in separate processes.

In production, this can be done  by running the app in multiple Docker containers or servers and load balancing between them.

Stateless frameworks are more robust because even if one process fails, other processes can continue
serving requests.
In Dash Enterprise Kubernetes, these containers can run on separate servers or even
separate regions, providing resiliency against server failure.

With a stateless framework, user sessions are not mapped 1-1 with server processes.
Each callback request can be executed on _any_ of the available processes.


{{oss {{dash-club}} }}

## Why Global Variables Will Break Your App

Dash is designed to work in multi-user environments where multiple people view the application at the
same time and have **independent sessions**.

If your app uses and modifies a global variable, then one user's session could set the variable to some value
which would affect the next user's session.

Dash is also designed to be able to run with **multiple workers** so that callbacks can be executed in parallel.



When Dash apps run across multiple workers, their memory
_is not shared_. This means that if you modify a global
variable in one callback, that modification will not be
applied to the other workers / processes.

---

Here is a sketch of an app that will _not work reliably_ because the callback modifies a global variable, which is outside of its scope.

{{example global_scope}}

The callback returns the correct output the very first time it is called, but once the global `df` variable is modified, any subsequent callback
that uses that dataframe is not using the original data anymore.

To improve this app, reassign the filtered dataframe to a new variable inside the callback as shown below, or follow one of the strategies outlined in the next parts of this guide.

{{example global_scope_fixed}}

## Storing Shared Data

To share data safely across multiple
processes or servers, we need to store the data somewhere that is accessible to
each of the processes.

There are three places you can store this data:

- In the user's browser session, using [dcc.Store](/dash-core-components/store)

- On the disk (e.g. in a file or database)

- In server-side memory (RAM) shared across processes and servers such as a Redis database. Dash Enterprise includes  <dccLink href="/dash-enterprise/redis-database" children="onboard, one-click Redis databases"/> for this purpose.


The following examples illustrate some of these approaches.

### Example 1 - Storing Data in the Browser with `dcc.Store`

To save data in the user's browser's session:

- The data has to be converted to a string like JSON or base64 encoded binary data for storage
- Data that is cached in this way will _only be available in the user's current session_.
  - If you open up a new browser window, the app's callbacks will always
    re-compute the data. The data is only cached between
    callbacks within the same session.
  - This method doesn't increase the
    memory footprint of the app.
  - There could be a cost in network traffic. If you're sharing 10MB
    of data between callbacks, then that data will be transported over
    the network between each callback.
  - If the network cost is too high, then compute the aggregations
    upfront and transport those.
    Your app likely won't be displaying 10MB of data,
    it will just be displaying a subset or an aggregation of it.

The example below shows one of the common ways you can leverage `dcc.Store`: if processing a dataset takes a long time and different outputs use this dataset, `dcc.Store` can be used to store the processed data as an _intermediate value_ that can then be used as an input in multiple callbacks to generate different outputs. This way, the expensive data processing step is only performed once in one callback instead of repeating the same expensive computation multiple times in each callback.

{{example dccstore}}

Notice that the data needs to be serialized into a JSON string before being placed in storage. Also note how the processed data gets stored in `dcc.Store` by assigning the data as its output, and then the same data gets used by multiple callbacks by using the same `dcc.Store` as an input.

{{details
Note about a previous version of this example

_This example used to be implemented with a "hidden div".
We no longer recommend using the hidden div approach, and instead recommend using
`{{component dcc.Store}}`, which stores the data in the user's browser's memory instead
of the browser's DOM and makes the intent more clear._
}}

---

### Example 2 - Computing Aggregations Upfront

Sending the computed data over the network can be expensive if
the data is large. In some cases, serializing this data to JSON
can also be expensive.

In many cases, your app will only display a subset or an aggregation
of the processed data. In these cases, you could precompute
the aggregations in your data processing callback and transport these
aggregations to the remaining callbacks.

Here's a simple example of how you might transport filtered or aggregated data to multiple callbacks,
again using the same `dcc.Store`.

{{example precompute}}

---

### Example 3 - Caching and Signaling

This example:
- Uses the `memoise` package for storing "global variables" in an in-memory cache on the server.
This data is accessed through a function (`global_store()`), the output of which is cached and keyed by its input arguments.
- Uses the `dcc.Store` solution to send a signal to the other
callbacks when the expensive computation is complete.
- Note that instead of an in-memory cache, you could also save this to the file
system. See
the documentation for the `cache` argument in `memoise()`
for more details.
- This “signaling” is performant because it allows the expensive
computation to only take up one process and be performed once.
Without this type of signaling, each callback could end up
computing the expensive computation in parallel,
locking four processes instead of one.

Another benefit of this approach is that future sessions can
use the pre-computed value.
This will work well for apps that have a small number of inputs.

Here's what this example looks like.

![Example of a Dash App that uses Caching](assets/images/gallery/caching.gif)

{{details Here's what this example looks like in code:

{{example caching}}
}}

Some things to note:

- We've simulated an expensive process by using a system sleep of 3 seconds.
- When the app loads, it takes three seconds to render all four graphs.
- The initial computation only blocks one process.
- Once the computation is complete, the signal is sent and four callbacks
are executed in parallel to render the graphs.
Each of these callbacks retrieves the data from the
"global server-side store": the in-memory cache or filesystem cache.

- As we are running the server with multiple processes, we set `threaded` to `False`. A Flask server can't be be both multi-process and multi-threaded.
- Selecting a value in the dropdown will take less than three seconds
if it has already been selected in the past.
This is because the value is being pulled from the cache.
- Similarly, reloading the page or opening the app in a new window
  is also fast because the initial state and the initial expensive
  computation has already been computed.

***

### Example 4 - User-Based Session Data on the Server

The previous example cached computations in a way that was accessible for all users.

Sometimes you may want to keep the data isolated to user sessions:
one user's derived data shouldn't update the next user's derived data.
One way to do this is to save the data in a `dcc.Store`,
as demonstrated in the first example.

Another way to do this is to save the data in a cache along
with a session ID and then reference the data
using that session ID. Because data is saved on the server
instead of transported over the network, this method is generally faster than the
`dcc.Store` method.

*This method was originally discussed in a
[Dash Community Forum thread](https://community.plotly.com/t/capture-window-tab-closing-event/7375/2?u=chriddyp).*

This example:
- Caches data using `memoise(cache = cachem::cache_disk("df_user_cache"))` into the a `df_user_cache` directory. You can also save to an in-memory cache or database such as Redis instead.
- Serializes the data as JSON.
    

- Creates unique session IDs for each session and stores it as the data
of `dcc.Store` on every page load. This means that every user
session has unique data in the `dcc.Store` on their page.

> Note: As with all examples that send data to the client, be aware
> that these sessions aren't necessarily secure or encrypted.
> These session IDs may be vulnerable to
> [Session Fixation](https://en.wikipedia.org/wiki/Session_fixation)
> style attacks.

{{details Here's what this example looks like in code:

{{example user_caching}}

}}

![Example of a Dash App that uses User Session Caching](assets/images/gallery/user-session-caching.gif)

There are three things to notice in this example:

- The timestamps of the dataframe don't update when we retrieve
the data. This data is cached as part of the user's session.
- Retrieving the data initially takes three seconds but successive queries
are instant, as the data has been cached.
- The second session displays different data than the first session:
  the data that is shared between callbacks is isolated to individual
  user sessions.

Questions? Discuss these examples on the
[Dash Community Forum](https://community.plotly.com/c/dash).
