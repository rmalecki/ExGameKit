defmodule GameKit.LocalPlayer do
  @moduledoc false

  def verify(player_id, bundle_id, timestamp, signature, salt, public_key_url) do
    with {:ok, key} <- GameKit.PublicKeyCache.get(public_key_url),
         {:ok, salt_decoded} <- Base.decode64(salt),
         payload = "#{player_id}#{bundle_id}#{timestamp}#{salt_decoded}",
         {:ok, signature_decoded} <- Base.decode64(signature) do
      try do
        :crypto.verify(:rsa, :sha256, payload, signature_decoded, key)
      rescue
        e -> {:error, e}
      end
    else
      :error -> {:error, "Invalid base64-encoded salt or signature"}
      {:error, e} -> {:error, e}
    end
  end

end
