import {useConnection} from 'wagmi';
import Login from "./Login";

export default function App(){

  const connection = useConnection();

  return (
    <>
      {
        connection.status === "connected"
          ? <Vote />
          : <Login /> 
      }
    </>
  )
}