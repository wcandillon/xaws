(:
 : Copyright 2010 XQuery.me
 :
 : Licensed under the Apache License, Version 2.0 (the "License");
 : you may not use this file except in compliance with the License.
 : You may obtain a copy of the License at
 :
 : http://www.apache.org/licenses/LICENSE-2.0
 :
 : Unless required by applicable law or agreed to in writing, software
 : distributed under the License is distributed on an "AS IS" BASIS,
 : WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 : See the License for the specific language governing permissions and
 : limitations under the License.
:)

(:~
 : <p>
 :      This test returns all of the attributes associated with the item.
 :      Optionally, the attributes returned can be limited to one or more 
 :      specified attribute name parameters.
 : </p>
 :
 : @author Klaus Wichmann klaus [at] xquery [dot] co [dot] uk
 :)
module namespace test = 'http://test/xaws/sdb/particular_tests/get_attributes';

import module namespace domain = 'http://www.xquery.me/modules/xaws/sdb/domain' at '/uk/co/xquery/www/modules/xaws/sdb/domain.xq';
import module namespace error = 'http://www.xquery.me/modules/xaws/helpers/error' at '/uk/co/xquery/www/modules/xaws/helpers/error.xq';

declare namespace aws = "http://sdb.amazonaws.com/doc/2009-04-15/";
declare namespace ann = "http://www.zorba-xquery.com/annotations";
declare namespace err = "http://www.w3.org/2005/xqt-errors";

declare %ann:sequential function test:run($testconfig as element(config),$testresult as element(testresult)) as element(testresult) {
    variable $success := false();
    variable $msg := ();
    variable $testname := "sdb_get_attributes";
    variable $aws-key := string($testconfig/aws-key/text());
    variable $aws-secret := string($testconfig/aws-secret/text());
    variable $domain-name := string($testconfig/domain-name/text());
    variable $item-name := string($testconfig/item-name/text());
    
    try {
        (: get all attributes for the specified item :)
        let $result := domain:get-attributes($aws-key,$aws-secret,$domain-name,$item-name)[2]
        
        return 
            (: save the (formatted) list in the testresult-message :)
            $msg := $result//aws:GetAttributesResult;
            $success := true();
            
    } catch * { 
        $msg := error:to-string($err:code,$err:description,$err:value);
    }
    
    insert nodes (
                    <particular_test name="{$testname}" success="{$success}">
                        <result>{$msg}</result>
                    </particular_test>
    ) as last into $testresult;
    
    $testresult
};
