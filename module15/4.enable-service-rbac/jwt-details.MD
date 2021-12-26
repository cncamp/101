### create RequestAuthentication which enables jwt token validation
after this, requests with invalid token will be rejected
requests without token or with valid token will be accepted
```
kubectl apply -f requestauthentication.yaml
```
### create AuthorizationPolicy which enables check of authorization
after this, requests without token will be rejected
```
kubectl apply -f authorizationpolicy.yaml
```
### access productpage and you will see 
```
Sorry, product details are currently unavailable for this book.
```
### get jwt token
```
TOKEN_GROUP=$(curl https://raw.githubusercontent.com/istio/istio/release-1.12/security/tools/jwt/samples/groups-scope.jwt -s) && echo "$TOKEN_GROUP" | cut -d '.' -f2 - | base64 --decode -

echo eyJhbGciOiJSUzI1NiIsImtpZCI6IkRIRmJwb0lVcXJZOHQyenBBMnFYZkNtcjVWTzVaRXI0UnpIVV8tZW52dlEiLCJ0eXAiOiJKV1QifQ.eyJleHAiOjM1MzczOTExMDQsImdyb3VwcyI6WyJncm91cDEiLCJncm91cDIiXSwiaWF0IjoxNTM3MzkxMTA0LCJpc3MiOiJ0ZXN0aW5nQHNlY3VyZS5pc3Rpby5pbyIsInNjb3BlIjpbInNjb3BlMSIsInNjb3BlMiJdLCJzdWIiOiJ0ZXN0aW5nQHNlY3VyZS5pc3Rpby5pbyJ9.EdJnEZSH6X8hcyEii7c8H5lnhgjB5dwo07M5oheC8Xz8mOllyg--AHCFWHybM48reunF--oGaG6IXVngCEpVF0_P5DwsUoBgpPmK1JOaKN6_pe9sh0ZwTtdgK_RP01PuI7kUdbOTlkuUi2AO-qUyOm7Art2POzo36DLQlUXv8Ad7NBOqfQaKjE9ndaPWT7aexUsBHxmgiGbz1SyLH879f7uHYPbPKlpHU6P9S-DaKnGLaEchnoKnov7ajhrEhGXAQRukhDPKUHO9L30oPIr5IJllEQfHYtt6IZvlNUGeLUcif3wpry1R5tBXRicx2sXMQ7LyuDremDbcNy_iE76Upg| cut -d '.' -f2 -|base64 -d
{"exp":3537391104,"groups":["group1","group2"],"iat":1537391104,"iss":"testing@secure.istio.io","scope":["scope1","scope2"],"sub":"testing@secure.istio.io"}
```
 
### add jwt token to productpage source code
```
cat productpage-v2/productpage.py
```
### build docker images for productpage v2 with jwt token
### create product page v2
```
kubectl apply -f productpage-v2/productpage.yaml
```
### access productpage and you will see error in 50% percents
```
Sorry, product details are currently unavailable for this book.
```
### scale done v1 and keep v2 only
### this is how microservice talks to each others with jwt token
- requestauthentication defines how the jwt token can be decrypted
- authorizationpolicy defines how the request SPIFFE or request princile being authorized