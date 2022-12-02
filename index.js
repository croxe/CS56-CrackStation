const AWS = require("aws-sdk");

const dynamo = new AWS.DynamoDB.DocumentClient();

exports.handler = async (event, context) => {
  let body;
  let statusCode = 200;
  const headers = {
    "Content-Type": "application/json"
  };

  try {
    switch (event.routeKey) {
      case "GET /password/{shaHash}":
        body = await dynamo
          .get({
            TableName: "hashedPasswords",
            Key: {
              shaHash: event.pathParameters.shaHash.toUpperCase()
            }
          })
          .promise();
        if(body.length == 0) {
          body = "error: "
        }
        body = body.Item;
        let response = '{\"' + body.shaHash + '\":\"' + body.password + '\"}' 
        body = JSON.parse(response)
        break;
      default:
        throw new Error(`Unsupported route: "${event.routeKey}"`);
    }
  } catch (err) {
    statusCode = 404;
    let response = '{"error":"Password is uncrackable"}'
    body = JSON.parse(response);
  } finally {
    body = JSON.stringify(body);
  }

  return {
    statusCode,
    body,
    headers
  };
};