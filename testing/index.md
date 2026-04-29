---
url: /testing
name: Dash Testing
description:
    "An introduction to testing your dash app with selenium"
icon: scalability.svg
languages:
    - python
    - r
---

# ![](/assets/images/language_icons/r-lang_50px.svg) Dash Testing

`dash.testing` provides custom Dash [pytest](https://docs.pytest.org) fixtures and a set of testing APIs for unit and end-to-end testing.
This tutorial shows how to write and run tests for a Dash app.


## Dash for R Testing

We released [Dash for R](https://medium.com/@plotlygraphs/announcing-dash-for-r-82dce99bae13)
in July 2019.  It extends the *Python* package
`dash.testing` to support Dash for R apps.
The `dashr` fixture gives a test development experience in
Dash for R that's nearly identical to the `dash_duo` fixture in
Dash for Python. A `dashr` fixture is an instance of
Python class which provides a reliable framework to execute the app and test
one or more of its features via Selenium WebDriver. For more details,
please visit [pytest documentation](https://docs.pytest.org/en/latest/fixture.html).



## Installing `dash.testing`

Install `dash.testing` with:

```
python -m pip install dash[testing]
```

In some shells (for example, Zsh), you may need to escape the opening bracket, `[`:

```
python -m pip install dash\[testing]
```



## Example

Here is a simple example runnable with `pytest`. Your Dash App is written
as a string inside the Python test code (the `app` argument can also be a
valid path to a `.R` file), the app is then executed by `Rscript` within
a Python `subprocess` and we can use the same set of API calls to
test it exactly as we do Dash testing in Python Apps.

```python
# the app is a raw string variable defining the Dash App in R
app = '''
library(dash)
library(dashHtmlComponents)
app <- Dash$new()
app$layout(htmlDiv(list(htmlDiv(id='container',children='Hello Dash for R testing'))))
app$run_server()
'''
# a test case is a simple Python function with the same prefix convention
# dashr is the default fixture combines the API for serving the app
# and Selenium tests.
def test_rstr001_r_with_string(dashr):
    # Since the app is the string chunk we defined above, the dashr
    # fixture creates an unique temporary folder to dump the content into
    # `app.R` and copies any possible subfolders (usually
    # assets or clientside source code) to the same temporary folder
    # start_server by default uses the temporary folder as current working
    # folder You can change this with `start_server(app, cwd='/my/cwd/')`
    dashr.start_server(app)
    assert dashr.find_element("#container").text == "Hello Dash for R Testing"

def test_rstr002_r_with_file_path(dashr):
    # Alternatively, the app can be a path to a separate file containing your Dash for R app
    # the `os.path.dirname(__file__)` is an useful Python trick to get the path
    # of the currently running script, so it will always work no matter where you start the
    # test runner.
    dashr.start_server(
        app=os.path.join(os.path.dirname(__file__), "assets/demo_hello.R))
    assert dashr.find_element("#container").text == "Hello Dash for R Testing"
```


## Running Tests
There are many ways to run your tests, and you can change how your tests run by adding flags to
the [`pytest`](https://docs.pytest.org) command.

### All Tests

You can run all tests in the current working directory (and its subdirectories) with:

```
pytest
```

Any tests in .py files with names that start with *test_* or end with *_test* are run.

### Specific Tests

In the example above, we gave our test cases IDs.
We can use these to run a specific test:

```
pytest -k rstr001
```


### WebDriver Options
There are different ways to configure your WebDriver when running end-to-end tests.

#### With an Alternative Web Driver

ChromeDriver is the default WebDriver, but `dash.testing` also supports geckodriver for Firefox.
Add the `--webdriver Firefox` flag when running tests to use it:

```shell
pytest --webdriver Firefox -k 001
```

#### In Headless Mode

You can run tests in [headless](https://developer.chrome.com/blog/headless-chrome/) mode, if you don't need to see
the tests in a browser UI:

```shell
pytest --headless -k 001
```

#### Using a Selenium Grid

You can use Selenium Grid to run tests across multiple machines. To run tests with a local hosted grid at `http://localhost:4444/wd/hu`:

```shell
pytest --remote -k 001
```

`http://localhost:4444/wd/hu` is the default value. To add an different remote, use the `--remote-url` flag:

```shell
pytest --webdriver Firefox --remote-url https://grid_provider_endpoints
```
Note: If you set `--remote-url`, and the value is different to the default value, `http://localhost:4444/wd/hu`, you don't need to include the `--remote` flag.

#### Caveats

We can't guarantee that the above examples work with every Selenium Grid. There may be limitations because of how your network is configured. For example, because of:

- A different hosting OS
- How docker-compose is configured

If you encounter issues, it may be because you need to do some auxiliary WebDriver options tuning to run the tests. Here are some things to try:

- Change the default logging level with `--log-cli-level DEBUG`.
- Customize your browser options. There is a back door for browser option customization by a `pytest_setup_options` hook defined in `plugin.py`. The example below is to use the headless mode with Chrome WebDriver in Windows. There is a workaround by adding    `--disable-gpu` in the options.

```
from selenium.webdriver.chrome.options import Options

def pytest_setup_options():
	options = Options()
	options.add_argument('--disable-gpu')
	return options
```

## Fixtures

To avoid accidental name collision with other pytest plugins, all Dash test
fixtures start with the prefix `dashr`.


- `dashr`
The default fixture for Dash for R integration tests. As `dash_duo` in Python,
it contains a `dashr_server` and a Selenium WebDriver with the same Dash
testing APIs.
- `dashr_server`
Start your Dash for R App with `Rscript` in a python `subprocess`. Note that
unlike python server fixtures, the start server arguments can only be
configured inside the Dash for R App.


## APIs

### Selenium Overview

`dashr` exposes the Selenium WebDriver via the
property `driver`, e.g. `dash_duo.driver`, which gives you full access to
the [Python Selenium API](https://selenium-python.readthedocs.io/api.html).
(*Note that this is not the official Selenium documentation site, but has
somehow become the de facto Python community reference*)
One of the core components of Selenium testing is finding the
**web element** with a `locator`, and performing some actions like `click`
or `send_keys` on it, and waiting to verify if the expected state is met
after those actions. The check is considered as an acceptance criterion,
for which you can write in a standard Python `assert` statement.

#### Element Locators

There are several strategies to
[locate elements](https://selenium-python.readthedocs.io/locating-elements.html#locating-elements);
CSS selector and XPATH are the two most versatile ways. We recommend using
the **CSS Selector** in most cases due to its
[better performance and robustness](http://elementalselenium.com/tips/34-xpath-vs-css-revisited-2) across browsers.
If you are new to using CSS Selectors, these
[SauceLab tips](https://saucelabs.com/resources/articles/selenium-tips-css-selectors)
are a great start. Also, remember that
[Chrome Dev Tools Console](https://developers.google.com/web/tools/chrome-devtools/console/utilities)
is always your good friend and playground.

#### Waits

[This link](https://selenium-python.readthedocs.io/waits.html) covers
this topic nicely. For impatient readers, a quick take away is
quoted as follows:
The Selenium WebDriver provides two types of waits:
- **explicit wait**
    Makes WebDriver wait for a certain condition to occur before
    proceeding further with execution. All our APIs with `wait_for_*`
    falls into this category.
- **implicit wait**
    Makes WebDriver poll the DOM for a certain amount of time when trying
    to locate an element. We set a global two-second timeout at the
    `driver` level.
**Note** *all custom wait conditions are defined in `dash.testing.wait`
and there are two extra APIs `until` and `until_not` which are similar to
the explicit wait with WebDriver, but they are not binding to
WebDriver context, i.e. they abstract a more generic mechanism to
poll and wait for certain condition to happen*

### Browser APIs

This section lists a minimal set of browser testing APIs. They are
convenient shortcuts to Selenium APIs and have been approved in
our daily integration tests.
The following table might grow as we start migrating more legacy tests in
the near future. But we have no intention to build a comprehensive list,
the goal is to make writing Dash tests concise and error-free.
Please feel free to submit a community PR to add any missing ingredient,
we would be happy to accept that if it's adequate for Dash testing.

| API | Description |
| --- | ----------- |
| `find_element(selector)` | return the first found element by the `CSS selector`, shortcut to `driver.find_element_by_css_selector`. *note that this API will raise exceptions if not found, the `find_elements` API returns an empty list instead* |
| `find_elements(selector)` | return a list of all elements matching by the `CSS selector`, shortcut to `driver.find_elements_by_css_selector`|
| `multiple_click(selector, clicks)`| find the element with the `CSS selector` and clicks it with number of `clicks` |
| `wait_for_element(selector, timeout=None)` | shortcut to `wait_for_element_by_css_selector` the long version is kept for back compatibility. `timeout` if not set, equals to the fixture's `wait_timeout`|
| `wait_for_element_by_css_selector(selector, timeout=None)` | explicit wait until the element is present, shortcut to `WebDriverWait` with `EC.presence_of_element_located` |
| `wait_for_element_by_id(element_id, timeout=None)` | explicit wait until the element is present, shortcut to `WebDriverWait` with `EC.presence_of_element_located` |
| `wait_for_style_to_equal(selector, style, value, timeout=None)` | explicit wait until the element's style has expected `value`. shortcut to `WebDriverWait` with custom wait condition `style_to_equal`. `timeout` if not set, equals to the fixture's `wait_timeout`  |
| `wait_for_text_to_equal(selector, text, timeout=None)` | explicit wait until the element's text equals the expected `text`. shortcut to `WebDriverWait` with custom wait condition `text_to_equal`. `timeout` if not set, equals to the fixture's `wait_timeout` |
| `wait_for_contains_text(selector, text, timeout=None)` | explicit wait until the element's text contains the expected `text`. shortcut to `WebDriverWait` with custom wait condition `contains_text` condition. `timeout` if not set, equals to the fixture's `wait_timeout` |
| `wait_for_class_to_equal(selector, classname, timeout=None)` | explicit wait until the element's class has expected `value`. timeout if not set, equals to the fixture's `wait_timeout`. shortcut to `WebDriverWait` with custom `class_to_equal` condition.  |
| `wait_for_contains_class(selector, classname, timeout=None)` | explicit wait until the element's classes contains the expected `classname`. timeout if not set, equals to the fixture's `wait_timeout`. shortcut to `WebDriverWait` with custom `contains_class` condition.  |
| `wait_for_page(url=None, timeout=10)` | navigate to the `url` in webdriver and wait until the dash renderer is loaded in browser. use `server_url` if `url` is None |
| `toggle_window()` | switch between the current working window and the newly opened one. |
| `switch_window(idx)` | switch to window by window index. shortcut to `driver.switch_to.window`. raise `BrowserError` if no second window present in browser |
| `open_new_tab(url=None)` | open a new tab in browser with window name `new window`. `url` if not set, equals to `server_url` |
| `percy_snapshot(name, wait_for_callbacks=False)` | visual test API shortcut to `percy_runner.snapshot`. it also combines the snapshot `name` with the actual python versions. The `wait_for_callbacks` parameter controls whether the snapshot is taken only after all callbacks have fired; the default is `False`. |
| `visit_and_snapshot(resource_path, hook_id, wait_for_callbacks=True, assert_check=True)` | This method automates a common task during dash-docs testing: the URL described by `resource_path` is visited, and completion of page loading is assured by waiting until the element described by `hook_id` is fetched. Once `hook_id` is available, `visit_and_snapshot` acquires a snapshot of the page and returns to the main page. `wait_for_callbacks` controls if the snapshot is taken until all dash callbacks are fired, default True. `assert_check` is a switch to enable/disable an assertion that there is no devtools error alert icon. |
| `take_snapshot(name)` | hook method to take a snapshot while Selenium test fails. the snapshot is placed under `/tmp/dash_artifacts` in Linux or `%TEMP` in windows with a filename combining test case `name` and the running Selenium session id |
| `zoom_in_graph_by_ratio(elem_or_selector, start_fraction=0.5, zoom_box_fraction=0.2, compare=True)` | zoom out a graph (provided with either a Selenium WebElement or CSS selector) with a zoom box fraction of component dimension, default start at middle with a rectangle of 1/5 of the dimension use `compare` to control if we check the SVG get changed |
| `click_at_coord_fractions(elem_or_selector, fx, fy)` |  Use `ActionChains` to click a Selenium WebElement at a location a given fraction of the way `fx` between its left (0) and right (1) edges, and `fy` between its top (0) and bottom (1) edges. |
| `get_logs()` | return a list of `SEVERE` level logs after last reset time stamps (default to 0, resettable by `reset_log_timestamp`. **Chrome only** |
| `clear_input()` | simulate key press to clear the input |
| `driver` | property exposes the Selenium WebDriver as fixture property |
| `session_id` | property returns the Selenium session_id, shortcut to `driver.session_id` |
| `server_url` | set the server_url as setter so the Selenium is aware of the local server port, it also implicitly calls `wait_for_page`. return the server_url as property |
| `download_path` | property returns the download_path, note that dash fixtures are initialized with a temporary path from pytest `tmpdir` |

### Dash APIs

This section enumerates a full list of Dash App related properties and APIs
apart from the previous browser ones.

| API | Description |
| --- | ----------- |
| `devtools_error_count_locator` | property returns the selector of the error count number in the devtool UI |
| `dash_entry_locator` | property returns the selector of react entry point, it can be used to verify if an Dash app is loaded |
| `dash_outerhtml_dom` | property returns the BeautifulSoup parsed Dash DOM from outerHTML |
| `dash_innerhtml_dom` | property returns the BeautifulSoup parsed Dash DOM from innerHTML |
| `redux_state_paths` | property returns the `window.store.getState().paths` |
| `redux_state_rqs` | property returns `window.store.getState().requestQueue` |
| `window_store` | property returns `window.store` |
| `get_local_storage(store_id="local")` | get the value of local storage item by the id, default is `local` |
| `get_session_storage(session_id="session") ` | get the value of session storage item by the id, default is `session` |
| `clear_local_storage()` | shortcut to `window.localStorage.clear()` |
| `clear_session_storage()` | shortcut to `window.sessionStorage.clear()` |
| `clear_storage()` | clears both local and session storages |

## Debugging

### Verify Your Test Environment

If you run the integration in a virtual environment, make sure you are
getting the latest commit in the **master** branch from each component, and
that the installed `pip` versions are correct.
Note: *We have some enhancement initiatives tracking in this [issue](https://github.com/plotly/dash/issues/759)*

### Run the CI Job Locally

The [CircleCI Local CLI](https://circleci.com/docs/2.0/local-cli/) is a
handy tool to execute some jobs locally. It gives you an earlier warning
before even pushing your commits to remote. For example, it's always
recommended to pass lint and unit tests job first on your local machine. So
we can make sure there are no simple mistakes in the commit.
```shell
# install the cli (first time only)
$ curl -fLSs https://circle.ci/cli | bash && circleci version
# run at least the lint & unit test job on both python 2 and 3
# note: the current config requires all tests pass on python 2.7, 3.6 and 3.7.
$ circleci local execute --job lint-unit-27 && $ circleci local execute --job lint-unit-37
```

### Increase the Verbosity of pytest Logging Level

`pytest --log-cli-level DEBUG -k bsly001`

You can get more logging information from Selenium WebDriver, Flask server,
and our test APIs.

```bash
14:05:41 | DEBUG | selenium.webdriver.remote.remote_connection:388 | DELETE http://127.0.0.1:53672/session/87b6f1ed3710173eff8037447e2b8f56 {"sessionId": "87b6f1ed3710173eff8037447e2b8f56"}
14:05:41 | DEBUG | urllib3.connectionpool:393 | http://127.0.0.1:53672 "DELETE /session/87b6f1ed3710173eff8037447e2b8f56 HTTP/1.1" 200 72
14:05:41 | DEBUG | selenium.webdriver.remote.remote_connection:440 | Finished Request
14:05:41 | INFO | dash.testing.application_runners:80 | killing the app runner
14:05:41 | DEBUG | urllib3.connectionpool:205 | Starting new HTTP connection (1): localhost:8050
14:05:41 | DEBUG | urllib3.connectionpool:393 | http://localhost:8050 "GET /_stop-3ef0e64e8688436caced44e9f39d4263 HTTP/1.1" 200 29
```

### Selenium Snapshots

If you run your tests with CircleCI dockers (locally with `CircleCI CLI`
and/or remotely with `CircleCI`).
Inside a docker run or VM instance where there is no direct access to the
video card, there is a known limitation that you cannot see anything from
the Selenium browser on your screen. Automation developers use
[Xvfb](https://www.x.org/releases/X11R7.6/doc/man/man1/Xvfb.1.xhtml) as
a workaround to solve this issue. It enables you to run graphical
applications without a display (e.g., browser tests on a CI server) while
also having the ability to take screenshots.
We implemented an automatic hook at the test report stage, it checks if a
test case failed with a Selenium test fixture. Before tearing down every
instance, it will take a snapshot at the moment where your assertion is
`False` or having a runtime error. refer to [Browser APIs](#browser-apis)
*Note: you can also check the snapshot directly in CircleCI web page
under `Artifacts` Tab*

### Percy Snapshots

There are two customized `pytest` arguments to tune Percy runner:
1. `--nopercyfinalize` disables the Percy finalize in dash fixtures. This
is required if you run your tests in parallel, then you add an extra
`percy finalize --all` step at the end. For more details, please visit
[Percy Documents](https://docs.percy.io/docs/parallel-test-suites).
2. `--percy-assets` lets Percy know where to collect additional assets
such as CSS files.
