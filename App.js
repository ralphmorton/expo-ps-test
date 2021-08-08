import * as Main from "./output/Main"
import getConfig from './config'

export default function App() {
  return Main.main(getConfig())()
}
