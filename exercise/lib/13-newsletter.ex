defmodule Newsletter do
  def read_emails(path) do
    {:ok, emails} = File.read(path)

    cond do
      emails == "" -> []
      emails -> emails |> String.trim() |> String.split()
    end
  end

  def open_log(path), do: File.open(path, [:write])

  def log_sent_email(pid, email), do: IO.puts(pid, email)

  def close_log(pid), do: File.close(pid)

  def send_newsletter(emails_path, log_path, send_fun) do
    pid_log = open_log(log_path)

    emails =
      read_emails(emails_path)
      |> Enum.each(fn email ->
        case send_fun.(email) do
          :ok -> log_sent_email(pid_log, email)
          _ -> :noop
        end
      end)

    close_log(pid_log)
  end
end
