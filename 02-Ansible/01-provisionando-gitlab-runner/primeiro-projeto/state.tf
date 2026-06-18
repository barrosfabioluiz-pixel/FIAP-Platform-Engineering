terraform {
  backend "s3" {
    # Troque pelo bucket criado no setup inicial (Modulo 01).
    # Nome de bucket S3 nao pode ter espacos nem maiusculas.
    bucket = "base-config-<SEU-RM>"
    key    = "teste"
    region = "us-east-1"
  }
}
