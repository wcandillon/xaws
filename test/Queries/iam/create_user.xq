import module namespace system = "http://www.zorba-xquery.com/modules/system";
 
import module namespace config = "http://www.xquery.me/modules/xaws/helpers/config";  
import module namespace user = "http://www.xquery.me/modules/xaws/iam/user"; 

declare namespace iam = "https://iam.amazonaws.com/doc/2010-05-08/";
declare namespace aws = "http://s3.amazonaws.com/doc/2006-03-01/";

declare variable $AWS_ACCESS_KEY := system:property("env.AWS_ACCESS_KEY");
declare variable $AWS_SECRET := system:property("env.AWS_SECRET");
declare variable $aws-config := config:create($AWS_ACCESS_KEY,$AWS_SECRET);

try { user:deleteUser($aws-config, "TestUser1"); } catch * { (); }

let $user := 
     <User>
       <Path>/sausalito/users/</Path>
       <UserName>TestUser1</UserName>
     </User>
return 
  user:createUser($aws-config, $user)/iam:CreateUserResponse/iam:CreateUserResult/iam:User/iam:UserName