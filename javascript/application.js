const GraphiQL = require('graphiql');
const React = require('react');
const ReactDOMClient = require('react-dom/client');
const GraphiQLToolkit = require('@graphiql/toolkit')

document.addEventListener("DOMContentLoaded", function (_) {
  const graphiqlContainer = document.getElementById("graphiql-container");
  const graphQLEndpoint = graphiqlContainer.dataset.graphqlEndpointPath;
  const providedHeaders = JSON.parse(graphiqlContainer.dataset.headers);

  const customFetch = function(url, options) {
    options.credentials = "include"
    return fetch(url, options)
  }

  const fetcher = GraphiQLToolkit.createGraphiQLFetcher({
    url: graphQLEndpoint,
    headers: providedHeaders,
    fetch: customFetch,
    enableIncrementalDelivery: true,
  })

  // Render <GraphiQL /> into the body.
  const initialQuery = graphiqlContainer.dataset.initialQuery;
  const shouldPersistHeaders = graphiqlContainer.dataset.shouldPersistHeaders;
  let elementProps = {
      fetcher: fetcher,
      defaultQuery: initialQuery ? initialQuery : undefined,
      headerEditorEnabled: graphiqlContainer.dataset.headerEditorEnabled === 'true',
      inputValueDeprecation: graphiqlContainer.dataset.inputValueDeprecation === 'true',
      shouldPersistHeaders: shouldPersistHeaders ? shouldPersistHeaders === 'true' : undefined
  };

  if (graphiqlContainer.dataset.queryParams === 'true') {
      let parameters = {};

      // Parse the search string to get url parameters
      window.location.search.substring(1).split('&').forEach(function (entry) {
          let eq = entry.indexOf('=');
          if (eq >= 0) {
              parameters[decodeURIComponent(entry.slice(0, eq))] = decodeURIComponent(entry.slice(eq + 1));
          }
      });

      // If variables was provided, try to format it
      if (parameters.variables) {
          try {
              parameters.variables = JSON.stringify(JSON.parse(parameters.variables), null, 2);
          } catch {
              // Do nothing, we want to display the invalid JSON as a string, rather than present an error
          }
      }

      // When the query and variables string is edited, update the URL bar so that it can be easily shared
      function updateURL() {
          const newSearch = '?' + Object.keys(parameters).map(function (key) {
              return encodeURIComponent(key) + '=' + encodeURIComponent(parameters[key]);
          }).join('&');
          history.replaceState(null, null, newSearch);
      }

      function onEditQuery(newQuery) {
          parameters.query = newQuery;
          updateURL();
      }

      function onEditVariables(newVariables) {
          parameters.variables = newVariables;
          updateURL();
      }

      Object.assign(elementProps, {
          query: parameters.query,
          variables: parameters.variables,
          onEditQuery: onEditQuery,
          onEditVariables: onEditVariables
      })
  }

  const root = ReactDOMClient.createRoot(document.getElementById("graphiql-container"))
  root.render(
      React.createElement(GraphiQL.GraphiQL, elementProps,
          React.createElement(GraphiQL.GraphiQL.Logo, {}, graphiqlContainer.dataset.logo)
      )
  );
});
