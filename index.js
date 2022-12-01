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
        body = body.Item;
        body = JSON.parse(JSON.stringify( body, ["shaHash","password"] , 3))
        break;
      case "POST /decrypt":
        let requestJSON = JSON.parse(event.body);
        body = await dynamo
          .get({
            TableName: "hashedPasswords",
            Key: {
              shaHash: requestJSON.shaHash.toUpperCase()
            }
          })
          .promise();
        body = body.Item;
        body = JSON.parse(JSON.stringify( body, ["shaHash","password"] , 3))
        break;
      default:
        throw new Error(`Unsupported route: "${event.routeKey}"`);
    }
  } catch (err) {
    statusCode = 400;
    body = err.message;
  } finally {
    body = JSON.stringify(body);
  }

  return {
    statusCode,
    body,
    headers
  };
};
