import System.Environment (getArgs)
import Convert

main = do
    args <- getArgs
    print . base16to64 $ args !! 0
