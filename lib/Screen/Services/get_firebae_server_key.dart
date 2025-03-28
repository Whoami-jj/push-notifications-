import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
  Future<String> getServerKeyToken() async {
    final scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];

    try {

      final credentials = ServiceAccountCredentials.fromJson({
        "type": "service_account",
        "project_id": "pushnotification-38002",
        "private_key_id": "d2d99db6d6c028cc665b698b1843c5138f781a19",
        "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCP/dO/wVukALCE\nf61XX5pGfh1JM8u3uZO8MFRjWWDG67XYvHcOjP665DfcgD3JJG/URjQa1JrmW9GF\niOcHWjSEVlM8lAXy+cGC67Ny2LDUAeot0L93hVrTt2HTlZaY5mk1hk/W0QCxNMcN\nbpo+BFYRb6rJkSeQYOzfKeqak/s2xCeqwAwNdtYIT0zSzqgmEXxVKjc2vNLXAELX\nh3wmioHm2Bhy+tJGXfV68/YKyKQ3R18+iEZ9Alw0sl5o10x2p4hUo8SCg6bFF5bK\ngeh3Pt6uUncGawpd29lMcqihUVdmZ/XbrspZRDuMi4XdkX8i2bJt1PBcD0np9gJp\npJSDD7HdAgMBAAECggEABZrUvjcRkR2xwUaTAb6n66yHCU1p1Zn0pTOgZUmaWcPd\nDTWw0LEuTSoK/ptDTGwNqk6dQpoZ+XODgVYl4ARj3O7bSJVecenE3Yq9LnA+2dHF\nQslIWqenNGyD8090UDlPyRSUUQFLrJooUV6HxHg4vW8CT9xFlPog3kLsbd3qvmPv\nUOO4bDoYwS0YdmMnEWahlAl+H5J5aoJxLmBu9c46cOWcPKiOzNQ8cpE8Pl8IZQHl\npnKaufyOY3DdpYhN1qCg00ufMAifW7FX5bSAHCKukeue/tfZROWm61A+QROzHMUs\nNbKxWsuv74l2x04ciRFdmGrV46QDxRx4NP1Jkd+FJQKBgQDBGzM9psJmGr9sMyPG\nLW5TyJjtNFBaG0au7WLjPV1LVEGk3WdZVWrwUz+/ezwxfIzVvdo71rUC3xUUwvxI\n47yiMpSCgmOu2pIj2p2dLIg7EYemzkflkBUtktRM8a+LsonWb4RfJBYqC0VD3u0+\nRfAZqC/6F0vtjaAQJo/GshPV7wKBgQC+44qq4a9r4vCNrw9j+RGmH6143iLqCIJQ\nfueMiyCLQf/O+o00XIYcDiVUZ65KYjAvWesJ40nMiix7e7ZZFNPfasU/08m53c5y\nVIF3FQuq4LY/3YjKNfM+8jOGmt0V0PD9t4pZzDTrWTGNrxKoTwYHyLZK0XenT8SA\n0TtIiB5g8wKBgBf7U8rFSgE6Mymx1DCJddkr4WocBBqcppOU4aIM/egcB6b85Bfh\nFs3P2Ovj1x7iM+9bi53A1WwM3mZcrM40kjmmhHEM1mphtKKFROu/GxAS5kDd/2nQ\nEgE96eXAYie8PYgHA255YdNI4QpDxjzknKPjEkpB2GkhHI7E6zgm53W7AoGASrLk\nWsaCTSe7ltZAoZCgFXAkBD55TzgRNsrSda8kBxrGrgpiI3FpkaT/eq4wCC+wR3da\ngL4O7RnNGm1pCCccWjuAAOAx+qgP17G2EBGORUo2R3u7wdWm4KULAMutZJIlHEQs\nwcMlmkuHFrjCBlcWNwmWPGUH+9M9RGOcXV/W830CgYEAnJ5dgO2Vqi6rg+sku6Aw\nW5hbMdj3Ot5eGMjIeX2MTbZkHZFcSBEQGcfRT2PoJ13WeYvPMFkw+pk6zVacos71\nY2mgw+pmnmhCWpMfQqbt6GyVeHY8hfKcxAoz52E/WAlogVmhssCU9VAWJ1WbHcEK\nZnB0/6F0qVYTkhcbsc472Ck=\n-----END PRIVATE KEY-----\n",
        "client_email": "firebase-adminsdk-fbsvc@pushnotification-38002.iam.gserviceaccount.com",
        "client_id": "113583574530572969963",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40pushnotification-38002.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com"
      });

      final client = await clientViaServiceAccount(credentials, scopes);
      final accessServerKey = client.credentials.accessToken.data;
      return accessServerKey;
    } catch (e) {
      print('Error getting server key token: $e');
      rethrow;
    }
  }
}