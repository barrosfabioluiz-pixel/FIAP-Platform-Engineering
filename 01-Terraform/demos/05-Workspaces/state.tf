terraform {
  backend "s3" {
    # Troque pelo nome do SEU bucket (criado no setup). Nome de bucket S3 nao
    # pode ter espacos nem maiusculas — use algo como base-config-<SEU-RM>.
    bucket = "base-config-SEU-RM"
    key    = "workspaces"
    region = "us-east-1"
  }
}
