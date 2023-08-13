defmodule PicChatWeb.MessageLiveTest do
  use PicChatWeb.ConnCase

  import Phoenix.LiveViewTest
  import PicChat.MessagesFixtures
  import PicChat.AccountsFixtures

  @create_attrs %{content: "some content"}
  @update_attrs %{content: "some updated content"}
  @invalid_attrs %{content: nil}

  defp create_message(_) do
    user = user_fixture()
    message = message_fixture(user_id: user.id)
    %{message: message, user: user}
  end

  describe "Index" do
    setup [:create_message]

    test "lists all messages", %{conn: conn, message: message} do
      {:ok, _index_live, html} = live(conn, ~p"/messages")

      assert html =~ "Listing Messages"
      assert html =~ message.content
    end

    test "saves new message", %{conn: conn, user: user} do
      conn = log_in_user(conn, user)
      {:ok, index_live, _html} = live(conn, ~p"/messages")

      {:ok, new_live, html} =
        index_live |> element("a", "New Message") |> render_click() |> follow_redirect(conn)

      assert_redirected(index_live, ~p"/messages/new")
      assert html =~ "New Message"

      assert new_live
             |> form("#message-form", message: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert new_live
             |> form("#message-form", message: @create_attrs)
             |> render_submit()

      assert_patch(new_live, ~p"/messages")

      html = render(new_live)
      assert html =~ "Message created successfully"
      assert html =~ "some content"
    end

    test "updates message in listing", %{conn: conn, message: message, user: user} do
      conn = log_in_user(conn, user)
      {:ok, index_live, _html} = live(conn, ~p"/messages")

      {:ok, edit_live, html} =
        index_live
        |> element("#messages-#{message.id} a", "Edit")
        |> render_click()
        |> follow_redirect(conn)

      assert html =~ "Edit Message"
      assert_redirect(index_live, ~p"/messages/#{message}/edit")

      assert edit_live
             |> form("#message-form", message: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert edit_live
             |> form("#message-form", message: @update_attrs)
             |> render_submit()

      assert_patch(edit_live, ~p"/messages")

      html = render(edit_live)
      assert html =~ "Message updated successfully"
      assert html =~ "some updated content"
    end

    test "deletes message in listing", %{conn: conn, message: message, user: user} do
      conn = log_in_user(conn, user)
      {:ok, index_live, _html} = live(conn, ~p"/messages")

      assert index_live |> element("#messages-#{message.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#messages-#{message.id}")
    end
  end

  describe "Show" do
    setup [:create_message]

    test "displays message", %{conn: conn, message: message} do
      {:ok, _show_live, html} = live(conn, ~p"/messages/#{message}")

      assert html =~ "Show Message"
      assert html =~ message.content
    end

    test "updates message within modal", %{conn: conn, message: message, user: user} do
      conn = log_in_user(conn, user)
      {:ok, show_live, _html} = live(conn, ~p"/messages/#{message}")

      {:ok, edit_live, html} =
        show_live |> element("a", "Edit") |> render_click() |> follow_redirect(conn)

      assert html =~ "Edit Message"
      assert_redirected(show_live, ~p"/messages/#{message}/show/edit")

      assert edit_live
             |> form("#message-form", message: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert edit_live
             |> form("#message-form", message: @update_attrs)
             |> render_submit()

      assert_patch(edit_live, ~p"/messages/#{message}")

      html = render(edit_live)
      assert html =~ "Message updated successfully"
      assert html =~ "some updated content"
    end
  end
end
