-- Copyright 2012 Marco Túlio Pimenta Gontijo <marcotmarcot@gmail.com>
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

-- base
import Control.Applicative
import Data.Maybe
import System.Environment hiding (getEnv)

-- unix
import System.Posix.Env

-- chuchu
import Test.Chuchu

-- HUnit
import Test.HUnit

defs :: Chuchu IO
defs
  = do
    Given "that I start the test" $ \() -> return ()
    When ("I set the " *> wildcard " as " *> text <* " into the environment")
      $ \x -> setEnv "environment" x True
    Then ("the " *> wildcard " should have " *> text <* " on its content")
      $ \n -> fromJust <$> getEnv "environment" >>= (@?= n)
    When
        ("I set the "
          *> wildcard " as e-mail "
          *> email
          <* " into the environment")
      $ \x -> setEnv "environment" x True
    Then
        ("the "
          *> wildcard " should have e-mail "
          *> email
          <* " on its content")
      $ \n -> fromJust <$> getEnv "environment" >>= (@?= n)

main :: IO ()
main = withArgs ["tests/data/environment.feature"] $ chuchuMain defs id
