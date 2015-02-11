import Control.Monad (forever)
import Data.Char (ord)
import Data.List (sortBy)
import Data.Bits (xor)
import Data.Word (Word8)
import Data.ByteString (ByteString)
import qualified Data.ByteString as ByteString (pack, unpack)
import qualified Data.ByteString.Char8 as Char8
import qualified Data.ByteString.Base16 as Base16
import Text.Printf (printf)

hexStringToWords :: String -> [Word8]
hexStringToWords = ByteString.unpack . fst . Base16.decode . Char8.pack

wordsToHexString :: [Word8] -> String
wordsToHexString = Char8.unpack . Base16.encode . ByteString.pack

decodeHexByteString :: String -> String
decodeHexByteString = Char8.unpack . fst . Base16.decode . Char8.pack

xorStringWithChar :: String -> Word8 -> String
xorStringWithChar string byte = wordsToHexString $ zipWith xor (hexStringToWords string) (repeat byte)

getGoodCharacterCount :: String -> Int
getGoodCharacterCount = sum . map (\ char -> if ord char == 32 || ord char >= 65 && ord char <= 122 then 1 else 0)

data Deciphering = Deciphering Word8 Int String

cipher    (Deciphering c _ _)   = c
goodCount (Deciphering _ gc _)  = gc
plaintext (Deciphering _ _ pt)  = pt

decipherString :: String -> Word8 -> Deciphering
decipherString string cipher = Deciphering cipher goodCount plaintext
    where
        plaintext = decodeHexByteString $ xorStringWithChar string cipher
        goodCount = getGoodCharacterCount plaintext

collectAllDecipherings :: String -> [Deciphering]
collectAllDecipherings string = map (decipherString string) [0::Word8 .. 255::Word8]

goodCountOrder :: Deciphering -> Deciphering -> Ordering
goodCountOrder (Deciphering _ gc1 _) (Deciphering _ gc2 _) = compare gc2 gc1

main = do
    input <- getContents 
    print . plaintext . head . sortBy goodCountOrder $ foldl1 (++) (map collectAllDecipherings (lines input))
