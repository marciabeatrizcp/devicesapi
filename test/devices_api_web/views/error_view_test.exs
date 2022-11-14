defmodule DevicesAPIWeb.ErrorViewTest do
  use DevicesAPIWeb.ConnCase, async: true

  import Phoenix.View

  test "renders default_error.json" do
    assert render(DevicesAPIWeb.ErrorView, "default_error.json", %{message: "reason"}) == %{
             error: "reason"
           }
  end

  test "renders field_errors.json" do
    messages = [
      {
        :password,
        {"should be at least %{count} character(s)", "teste"}
      },
      {
        :email,
        {"has invalid format", "teste"}
      }
    ]

    assert render(DevicesAPIWeb.ErrorView, "field_errors.json", %{message: messages}) ==
             %{
               error: [
                 %{error_message: "should be at least %{count} character(s)", field: :password},
                 %{error_message: "has invalid format", field: :email}
               ]
             }
  end

  test "renders field_error.json" do
    assigns = %{
      error: {
        :password,
        {"should be at least %{count} character(s)", "teste"}
      }
    }

    assert render(DevicesAPIWeb.ErrorView, "field_error.json", assigns) ==
             %{error_message: "should be at least %{count} character(s)", field: :password}
  end
end
