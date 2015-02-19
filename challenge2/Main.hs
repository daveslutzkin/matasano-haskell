import Cipher (base16StringXor)
import System.Environment (getArgs)

main = do
    args <- getArgs
    print $ base16StringXor (args !! 0) (args !! 1)
