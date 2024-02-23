document.addEventListener("DOMContentLoaded", function (_) {
    const graphiqlContainer = document.getElementById("graphiql-container");

    // Defines a GraphQL fetcher using the fetch API.
    function graphQLFetcher(graphQLParams, options) {
        const graphQLEndpoint = graphiqlContainer.dataset.graphqlEndpointPath;
        const providedHeaders = JSON.parse(graphiqlContainer.dataset.headers);

        return fetch(graphQLEndpoint, {
            method: 'post',
            headers: {...providedHeaders, ...options.headers},
            body: JSON.stringify(graphQLParams),
            credentials: 'include',
        }).then(function (response) {
            try {
                return response.json();
            } catch (error) {
                return {
                    "status": response.status,
                    "message": "The server responded with invalid JSON, this is probably a server-side error",
                    "response": response.text(),
                };
            }
        })
    }

    // Render <GraphiQL /> into the body.
    const initialQuery = graphiqlContainer.dataset.initialQuery;
    let elementProps = {
        fetcher: graphQLFetcher,
        defaultQuery: initialQuery ? initialQuery : undefined,
        headerEditorEnabled: graphiqlContainer.dataset.headerEditorEnabled === 'true',
        inputValueDeprecation: graphiqlContainer.dataset.inputValueDeprecation === 'true',  
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

    ReactDOM.render(
        React.createElement(GraphiQL, elementProps,
            React.createElement(GraphiQL.Logo, {}, graphiqlContainer.dataset.logo)
        ),
        document.getElementById("graphiql-container")
    );
});