{-# LANGUAGE OverloadedStrings #-}
module Main where 

import Network.HTTP
import Data.Aeson.Lens
import Control.Lens
import Data.Text

serverPath = "http://172.0.0.1"
databaseName = "mydb"
u = ("u", "root")
p = ("p", "root")

request :: [(String, String)] -> IO String
request urlvars = simpleHTTP (getRequest (serverPath ++ ":8086/db/" ++ databaseName ++ "/series?" ++ urlEncodeVars (u : p : urlvars))) >>= getResponseBody

requestDelete :: String -> IO String
requestDelete name = putStrLn ("Dropping " ++ name) >> request [("q", "drop series" ++ name)]

extractNames :: (Monad m, AsValue s) => s -> m [Text]
extractNames value = return (value ^.. values . key "name" . _String)

main :: IO ()
main = request [("q", "list series")] >>= extractNames >>= mapM_ (requestDelete . unpack)
