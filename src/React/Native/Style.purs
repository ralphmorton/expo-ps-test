module React.Native.Style (
  Style,
  style
) where

import React.Basic.DOM (CSS)
import Unsafe.Coerce (unsafeCoerce)

type Style = CSS

style :: forall r. Record r -> Style
style = unsafeCoerce
