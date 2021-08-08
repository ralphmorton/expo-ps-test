const firebase = require('firebase').default

exports.initFirebase_ = (config) => {
  return firebase.initializeApp(config)
}

exports.name_ = (app) => {
  return app.name
}

exports.firestore_ = (app) => {
  return app.firestore()
}

exports.auth_ = (app) => {
  return app.auth()
}
