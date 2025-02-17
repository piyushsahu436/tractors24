import 'package:minio/minio.dart';

final minio = Minio(
  endPoint: 'https://sin1.contabostorage.com/', // Change according to your region
  accessKey: '1eb0cbdee363c529fcbde7bf72e08ab3',
  secretKey: '650b25c6c6612a691a65654dc4ca77b1',
  useSSL: true, // Ensure HTTPS is used
  region: 'sin1', // Replace with your region if necessary
);
