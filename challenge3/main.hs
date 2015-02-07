import System.Environment (getArgs)
import Data.Char (ord)
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

sumWith :: (b -> Int) -> [b] -> Int
sumWith f = foldl (\ acc elem -> acc + f elem) 0

countGoodCharacters :: String -> Int
countGoodCharacters = sumWith (\ char -> if ord char >= 65 && ord char <= 122 then 1 else 0)

bestCipherByte :: String -> Word8
bestCipherByte string = snd $ bestCipherByte' string [0::Word8 .. 255::Word8] (0, 0::Word8)

bestCipherByte' :: String -> [Word8] -> (Int, Word8) -> (Int, Word8)
bestCipherByte' string [] best = best
bestCipherByte' string (byte:bytes) (maximum, bestByte)
    | count > maximum   = bestCipherByte' string bytes (count, byte)
    | otherwise         = bestCipherByte' string bytes (maximum, bestByte)
    where count = countGoodCharacters . decodeHexByteString $ xorStringWithChar string byte

main = do
    args <- getArgs
    let cipherText = args !! 0
    let cipherByte = bestCipherByte cipherText
    printf "'%c': \"%s\"\n" cipherByte $ decodeHexByteString $ xorStringWithChar cipherText cipherByte
