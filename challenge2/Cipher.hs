module Cipher where

import Prelude hiding (zipWith)
import Convert
import Data.Bits (xor)
import Data.ByteString (ByteString)
import Data.ByteString (pack, zipWith)
import Data.Char (chr, ord)

byteStringXor :: ByteString -> ByteString -> ByteString
byteStringXor bs1 bs2 = pack $ zipWith xor bs1 bs2

base16StringXor :: String -> String -> String
base16StringXor s1 s2 = byteStringToBase16 $ byteStringXor (base16ToByteString s1) (base16ToByteString s2)
