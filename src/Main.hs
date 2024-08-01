import System.Environment
import System.Exit
import System.IO


initialize :: IO ()
initialize = do
  envHOST <- readFile "/etc/hostname"
  envUSER <- getEnv "USER"
  envPWD  <- getEnv "PWD"
  putStr $ filter (/='\n') envHOST ++ "@" ++ envUSER ++ ":" ++ envPWD ++ "> "

cmds :: [String] -> String
cmds args
  | args == ["help"] = "this is the help, but it isn't implemented yet ^^'"
  | args == ["test"] = "test test test, this is for testing :D"
  | args == ["env"]  = mapM (\(x,y) -> "Key: " ++ x ++ "\nValue: " ++ y ++ "\n") getEnvironment
  | otherwise = ""

main :: IO ()
main = do
  initialize
  hFlush stdout
  args <- getLine
  putStrLn $ cmds $ words args
  main
