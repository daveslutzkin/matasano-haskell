import System.Environment (getArgs)
import Data.Bits (xor)
import Data.Word (Word8)
import Data.ByteString (ByteString)
import qualified Data.ByteString as ByteString (pack, unpack)
import qualified Data.ByteString.Char8 as Char8
import qualified Data.ByteString.Base16 as Base16

hexStringToWords :: String -> [Word8]
hexStringToWords = ByteString.unpack . fst . Base16.decode . Char8.pack

wordsToHexString :: [Word8] -> String
wordsToHexString = Char8.unpack . Base16.encode . ByteString.pack

xorHexStrings :: String -> String -> String
xorHexStrings s1 s2 = wordsToHexString (zipWith xor (hexStringToWords s1) (hexStringToWords s2))

main = do
    args <- getArgs
    print (xorHexStrings (args !! 0) (args !! 1))
