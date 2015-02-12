import System.Environment (getArgs)
import Data.Char (ord, chr)
import Data.Bits (xor)
import qualified Data.ByteString.Char8 as Char8
import qualified Data.ByteString.Base16 as Base16

xorStringWithChar :: String -> String -> String
xorStringWithChar s1 s2 = map chr $ zipWith xor (map ord s1) (map ord s2)

main = do
    args <- getArgs
    let plainText = args !! 0
    let cipherText = xorStringWithChar plainText $ foldr1 (++) (repeat "ICE")
    print $ Base16.encode $ Char8.pack cipherText
