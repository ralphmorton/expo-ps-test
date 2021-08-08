
const React = require("react")
const Google = require('expo-auth-session/providers/google')
const WebBrowser = require('expo-web-browser')

exports.useGoogleAuth_ = (config, setToken, setError) => {
  const [request, response, promptAsync] = Google.useIdTokenAuthRequest(
    {
      clientId: config.webClientId
    }
  )

  React.useEffect(() => {
    if (response) {
      if (response.type === 'success') {
        setToken(response.params.id_token)()
      } else if (response.type === 'error') {
        setError()
      }
    }
  }, [response])

  return {
    request,
    response,
    promptAsync
  }
}

exports.launch_ = (ctx) => {
  ctx.promptAsync()
}

exports.maybeCompleteAuthSession_ = () => {
  WebBrowser.maybeCompleteAuthSession()
}
