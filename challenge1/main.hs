import System.Environment (getArgs)
import Data.ByteString (ByteString)
import qualified Data.ByteString.Char8 as Char8 (pack, unpack)
import qualified Data.ByteString.Base16 as Base16 (decode)
import qualified Data.ByteString.Base64 as Base64 (encode)

changeBase16to64 :: String -> String
changeBase16to64 = Char8.unpack . Base64.encode . fst . Base16.decode . Char8.pack

main = do
    args <- getArgs
    print $ changeBase16to64 $ args !! 0
