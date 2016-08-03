defmodule GradeKings.User do
  use GradeKings.Web, :model

  import Comeonin.Bcrypt

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :encrypted_password, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps
  end

  @valid_attrs    ~w(first_name last_name email password password_confirmation)a
  @valid_password_attrs ~w(password password_confirmation)a

  def registration_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @valid_attrs)
    |> validate_length(:password, min: 8, max: 50)
    |> validate_length(:password_confirmation, min: 8, max: 50)
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    |> assign_password_hash
  end

  def change_password_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @valid_password_attrs)
    |> validate_length(:password, min: 8, max: 50)
    |> validate_length(:password_confirmation, min: 8, max: 50)
    |> validate_confirmation(:password)
    |> assign_password_hash
  end

  defp assign_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :encrypted_password, hashpwsalt(password))
      _ -> 
        changeset
    end
  end
end
