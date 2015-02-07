import System.Environment (getArgs)
import qualified Data.ByteString.Char8 as Char8
import qualified Data.ByteString.Base16 as Base16
import qualified Data.ByteString.Base64 as Base64

changeBase16to64 base16chars = do
    let (bytes, _) = Base16.decode base16chars
    Base64.encode bytes

main = do
    args <- getArgs
    print (changeBase16to64 (Char8.pack (args !! 0)))
