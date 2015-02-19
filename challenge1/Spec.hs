module Spec where

import Test.Hspec
import Convert

main :: IO ()
main = hspec $ do
    describe "Convert.base16to64" $ do
        it "converts the sample hex to base64" $
            base16to64
                "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"
                `shouldBe`
                "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t"
