import Constants from "expo-constants"

const ENV = {
  dev: {
    firebase: {
      apiKey: "AIzaSyAXOJRM_bftwa2R-a87zlGacrUzm3Pf9ck",
      authDomain: "expo-ps-test.firebaseapp.com",
      projectId: "expo-ps-test",
      storageBucket: "expo-ps-test.appspot.com",
      messagingSenderId: "82315778641",
      appId: "1:82315778641:web:e5da1ed3052c9bd3c9f670"
    },
    google: {
      webClientId: "82315778641-g1cu1oa99c2jcqvtpmhuhcqe58qaa1bb.apps.googleusercontent.com"
    }
  }
  //prod: {}
 };
 
 const getConfig = (env = Constants.manifest.releaseChannel) => {
  if (__DEV__) {
    return ENV.dev
  }
 };
 
 export default getConfig
