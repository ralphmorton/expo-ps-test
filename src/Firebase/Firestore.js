exports.collection_ = (store, name) => {
  return store.collection(name)
}

exports.onSnapshot_ = (coll, f) => {
  return coll.onSnapshot(
    snapshot => {
      const records = []
      snapshot.forEach(doc => {
        records.push({
          id: doc.id,
          body: doc.data()
        })
      })
      f(records)()
    }
  )
}
