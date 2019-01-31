# graphiql-rails

## 1.6.0 (Jan 21 2019)

### New Features

- Move JS into a `<script>` to avoid CSP issues #62

## 1.5.0 (Nov 6 2018)

### New Features

- Update GraphiQL to 0.12.0

## 1.4.11 (Jul 17 2018)

### New Features

- Add `.config.title` and `.config.logo` options #52
- Render helpful error data when requests fail #49

## 1.4.10 (Mar 9 2018)

### New Features

- Reduce dependencies to only `railties` and `sprockets-rails`

## 1.4.9 (Feb 21 2018)

### New Features

- Update GraphiQL to 0.11.11

## 1.4.8 (Nov 21 2017)

### New Features

- Render server errors as a JSON response

## 1.4.7 (Oct 31 2017)

### New Features

- Update GraphiQL to 0.11.10

### Bug Fixes

- Pick browser-ready React builds

## 1.4.6 (Oct 27 2017)

### New Features

- Update GraphiQL to 0.11.9

## 1.4.5 (Sept 26 2017)

### New Features

- Update GraphiQL to 0.11.5

## 1.4.4 (Aug 11 2017)

### Bug Fixes

- Properly escape quotes in `initial_query`

## 1.4.3 (Aug 5 2017)

### New Features

- Update GraphiQL to 0.11.2

## 1.4.2 (Jun 16 2017)

### New Features

- Update GraphiQL to 0.10.2

## 1.4.1 (Jan 5 2017)

### New Features

- Update to GraphiQL 0.8.1

## 1.4.0 (Nov 13 2016)

### New Features

- Update to GraphiQL 0.8.0

## 1.3.0 (Aug 21 2016)

### Breaking Changes

- `GraphiQL::Rails::WELCOME_MESSAGE` has been removed. GraphiQL's built-in welcome message is the default.

### New Features

- `config.headers` accepts procs for adding headers to the request
- Update to GraphiQL 0.7.3
