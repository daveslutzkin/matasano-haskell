import Crypto.Cipher (AES128, cipherInit, makeKey, ecbDecrypt)
import Data.ByteString (ByteString)
import qualified Data.ByteString.Char8 as Char8 (pack)
import qualified Data.ByteString.Base64 as Base64 (decode)

makeAES128CipherFromString :: String -> AES128
makeAES128CipherFromString = either (error . show) cipherInit . makeKey . Char8.pack

makePlaintextFromBase64 :: String -> ByteString
makePlaintextFromBase64 = either (error . show) id . Base64.decode . Char8.pack . filter (/= '\n')

main = do
    input <- getContents
    print $ ecbDecrypt (makeAES128CipherFromString "YELLOW SUBMARINE") (makePlaintextFromBase64 input)
