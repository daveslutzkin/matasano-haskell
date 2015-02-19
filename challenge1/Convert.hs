module Convert where

import Data.ByteString
import qualified Data.ByteString.Char8 as Char8 (pack, unpack)
import qualified Data.ByteString.Base16 as Base16 (decode, encode)
import qualified Data.ByteString.Base64 as Base64 (encode)

base16ToByteString :: String -> ByteString
base16ToByteString = fst . Base16.decode . Char8.pack

byteStringToBase16 :: ByteString -> String
byteStringToBase16 = Char8.unpack . Base16.encode

byteStringToBase64 :: ByteString -> String
byteStringToBase64 = Char8.unpack . Base64.encode

base16to64 :: String -> String
base16to64 = byteStringToBase64 . base16ToByteString
