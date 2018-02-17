#!/usr/bin/env stack
-- stack --resolver lts-9.13 --install-ghc runghc --package blaze --package markdown --package text

{-# LANGUAGE OverloadedStrings #-}

import Prelude hiding (head, div)
import Text.Blaze.Html.Renderer.Text
import Text.Blaze.Html5 ((!), h1, docTypeHtml, head, meta, link, title, body, div, button, a)
import Text.Blaze.Html5.Attributes (href, charset, name, content, rel, class_, type_, media, style)
import Text.Markdown
import qualified Data.Text.Lazy.IO as T
import qualified Data.Text.Lazy as T

main = renderHtml . fromMarkdownCV <$> T.readFile "cv.mk" >>= T.writeFile "index.html"  

fromMarkdownCV cv = docTypeHtml $ do
  head $ do
    meta ! charset "utf-8"
    title "Mateusz Curylo"
    meta ! name "description" ! content "My CV"
    meta ! name "author" ! content "Mateusz Curylo"
    meta ! name "viewport" ! content "width=device-width, initial-scale=1"
    link ! href "css/normalize.css" ! rel "stylesheet" ! media "screen"
    link ! href "css/skeleton.css" ! rel "stylesheet" ! media "screen"
    link ! href "css/print.css" ! rel "stylesheet" ! media "print"
    link ! href "favicon.ico" ! rel "icon" ! type_ "image/ico"
  body $ div ! class_ "container" $ div ! class_ "row"  $ do
    div ! class_ "seven columns printit topmargin" $ markdown def cv
    div ! class_ "one column printnot topmargin" ! style "text-align: right" $ a !  href "javascript:print()" $ button "Print"
