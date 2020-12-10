# Hydra Auth Practice Kit

This is a practice kit to experience the redirect in OpenID connect standard.
It is not recommended that the software engineers implement the workflow by themselves. 
This practice kit wants to give the engineers a sense how different parties in the worflow cooperates with each other.
We are going to use curl to execute the HTTP such that you can know the HTTP response correctly.

In this practice kit, we are going to use Hydra for the Auth flow. Hydra has modified a little in the OIDC. 
But, in general, it is the same story. So, it is a good platform to understand the OIDC with Hydra.

## Components in Your Mind
The only server we are going to standup is Hydra Auth server and Hydra admin server.
There are three servers you should keep in your mind, i.e. 5 servers in total.
* Auth Hydra Server - http://127.0.0.1:4444
* Admin Hydra Server - http://127.0.0.1:4445
* Client Server - http://my-cool-endpoint.localhost/callback
* Login Server - http://127.0.0.1:3000/
* Consent Server - http://127.0.0.1:3000/
The login server and consent server here are the same stuff but they have different roles actually. 
Technically, you can have different login and consent servers.

## Workflow
The ultimte goal for this exercise is to get the access token from Auth Hydra server.
You can follow this workflow to get it.
1. run `make hydra-up` to get two actual server to run
1. run `./register.sh` to register your client to **Admin Hydra Server**
1. run `./initiate.sh` to initiate the Auth process. It will call the **Auth Hydra Server**'s `/oauth2/auth` endpoint. 
    Here there are two important information.
    ```
    Location: http://127.0.0.1:3000/login?login_challenge=string
    Set-Cookie: oauth2_authentication_csrf_insecure=token; Path=/; Expires=Sat, 09 Jan 2021 03:19:07 GMT; Max-Age=2592000; HttpOnly; SameSite=Lax
    ```
    The location here is the redirect to **Login Server**. Login Server will get the login challenge string.
    We will discuss this login challenge string later on.
    For the second information, this is the cookie called `oauth2_authentication_csrf_insecure`.
    This cookie is used for recognizing the session for the user.
1. Copy the `login_challenge` from the previous step to `./login.sh`. You should put it on the `login_challenge` parameter
    in the query parameters.

    Here the request will be made by the **login server**. Be noticed that the login server will do this after the
    user has logined. And it will do the call behind the scene, i.e. user will not know this call. This call simply
    tells **Admin Hydra Server** that **login server** accepts the login and ask for the next step.

    In this step, you will get the response like this with 200 status code.
    ```
    {"redirect_to":"http://127.0.0.1:4444/oauth2/auth?login_verifier=8e61e39ccccd47c69eee43825a75d5ec"}
    ```
    So, login server will know that he need to redirect our client to **Auth Hydra Server** again here.
1. Copy the `login_verifier` from previous step to `./login_response.sh`. Also, you will need to get
    the cookie token into the header from the `./initiate.sh` response.

    Here the user will call the same endpoint as `./initate.sh` did. So, the cookie here actually will
    give the information which step the user is in.

    After the call, you will get another set of cookie and `consent_challenge`.
1. Repeat the steps as login but this time is for consent.
    In the last step `./consent_response.sh`, you will be told to redirect back to the redirect uri
    we have set before. Here you will get the `code` in the query parameters!
1. Paste the code you have got in last step into `get_access_token.sh`.
    You will get the access token in the response successfully!
