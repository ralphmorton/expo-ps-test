const firebase = require('firebase').default

const parseUser = (raw) => {
  return {
    uid: raw.uid,
    displayName: raw.displayName,
    email: raw.email,
    photoURL: raw.photoURL
  }
}

exports.googleSignIn_ = (auth, token, setUser, setError) => {
  const credential = firebase.auth.GoogleAuthProvider.credential(token)
  auth.signInWithCredential(credential)
    .then(res => setUser(parseUser(res.user))())
    .catch(err => setError())
}

exports.setPersistenceMode_ = (auth, mode) => {
  auth.setPersistence(mode)
}

exports.persistenceModeNone = firebase.auth.Auth.Persistence.NONE
exports.persistenceModeSession = firebase.auth.Auth.Persistence.SESSION
exports.persistenceModeLocal = firebase.auth.Auth.Persistence.LOCAL

exports.currentUser_ = (auth) => {
  return auth.currentUser
}

exports.onAuthStateChanged_ = (auth, setUser) => {
  return auth.onAuthStateChanged(
    (raw) => setUser(raw ? parseUser(raw) : null)(),
    (err) => setUser(null)()
  )
}
