Dicoding Restaurant API
Base URL
https://restaurant-api.dicoding.dev

Endpoints
Get List of Restaurant
Mendapatkan daftar restoran

URL: /list
Method: GET
Response:
{
  "error": false,
  "message": "success",
  "count": 20,
  "restaurants": [
      {
          "id": "rqdv5juczeskfw1e867",
          "name": "Melting Pot",
          "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
          "pictureId": "14",
          "city": "Medan",
          "rating": 4.2
      },
      {
          "id": "s1knt6za9kkfw1e867",
          "name": "Kafe Kita",
          "description": "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
          "pictureId": "25",
          "city": "Gorontalo",
          "rating": 4
      }
  ]
}
Get Detail of Restaurant
Mendapatkan detail restoran

URL: /detail/:id
Method: GET
Response:
{
  "error": false,
  "message": "success",
  "restaurant": {
      "id": "rqdv5juczeskfw1e867",
      "name": "Melting Pot",
      "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
      "city": "Medan",
      "address": "Jln. Pandeglang no 19",
      "pictureId": "14",
      "categories": [
          {
              "name": "Italia"
          },
          {
              "name": "Modern"
          }
      ],
      "menus": {
          "foods": [
              {
                  "name": "Paket rosemary"
              },
              {
                  "name": "Toastie salmon"
              }
          ],
          "drinks": [
              {
                  "name": "Es krim"
              },
              {
                  "name": "Sirup"
              }
          ]
      },
      "rating": 4.2,
      "customerReviews": [
          {
              "name": "Ahmad",
              "review": "Tidak rekomendasi untuk pelajar!",
              "date": "13 November 2019"
          }
      ]
  }
}
Search Restaurant
Mencari restoran berdasarkan nama, kategori, dan menu.

URL: /search?q=<query>
Method: GET
Response:
{
  "error": false,
  "founded": 1,
  "restaurants": [
      {
          "id": "fnfn8mytkpmkfw1e867",
          "name": "Makan mudah",
          "description": "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, ...",
          "pictureId": "22",
          "city": "Medan",
          "rating": 3.7
      }
  ]
}
Add Review
Menambahkan review pada restoran

URL: /review
Method: POST
Headers:
Content-Type: application/json
Body:
JSON: {"id": string, "name": string, "review": string}
Response:
{
"error": false,
"message": "success",
"customerReviews": [
  {
    "name": "Ahmad",
    "review": "Tidak rekomendasi untuk pelajar!",
    "date": "13 November 2019"
  },
  {
    "name": "test",
    "review": "makanannya lezat",
    "date": "29 Oktober 2020"
  }
]
}
Restaurant Image
Mendapatkan gambar restoran

Small resolution: https://restaurant-api.dicoding.dev/images/small/<pictureId>
Medium resolution: https://restaurant-api.dicoding.dev/images/medium/<pictureId>
Large resolution: https://restaurant-api.dicoding.dev/images/large/<pictureId>