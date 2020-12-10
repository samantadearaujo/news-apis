# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     AppNews.Repo.insert!(%AppNews.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias AppNews.Repo
alias AppNews.Authories.Author
alias AppNews.Categories.Category
alias AppNews.Sources.Source
alias AppNews.Sources.CategoriesAuthories

author_1 = %Author{name: "Victor Félix"} |> AppNews.Repo.insert!()
author_2 = %Author{name: "Lavínia Félix Costa"} |> AppNews.Repo.insert!()
author_3 = %Author{name: "Valetim Ribeiro"} |> AppNews.Repo.insert!()
author_4 = %Author{name: "Gabriel Medina"} |> AppNews.Repo.insert!()

category_1 = %Category{name: "Esportes"} |> Repo.insert!()
category_2 = %Category{name: "Politica"} |> Repo.insert!()
category_3 = %Category{name: "Tempo"} |> Repo.insert!()

categoryAuthories_1 = %CategoriesAuthories{categoryID: category_1.id, authorID: author_1.id}
categoryAuthories_2 = %CategoriesAuthories{categoryID: category_1.id, authorID: author_2.id}
categoryAuthories_3 = %CategoriesAuthories{categoryID: category_2.id, authorID: author_3.id}
categoryAuthories_4 = %CategoriesAuthories{categoryID: category_2.id, authorID: author_4.id}
categoryAuthories_5 = %CategoriesAuthories{categoryID: category_3.id, authorID: author_1.id}
categoryAuthories_6 = %CategoriesAuthories{categoryID: category_3.id, authorID: author_2.id}
categoryAuthories_7 = %CategoriesAuthories{categoryID: category_1.id, authorID: author_3.id}
categoryAuthories_8 = %CategoriesAuthories{categoryID: category_2.id, authorID: author_4.id}
categoryAuthories_9 = %CategoriesAuthories{categoryID: category_3.id, authorID: author_1.id}
categoryAuthories_10 = %CategoriesAuthories{categoryID: category_1.id, authorID: author_2.id}
categoryAuthories_11 = %CategoriesAuthories{categoryID: category_2.id, authorID: author_3.id}
categoryAuthories_12 = %CategoriesAuthories{categoryID: category_3.id, authorID: author_4.id}
categoryAuthories_13 = %CategoriesAuthories{categoryID: category_1.id, authorID: author_1.id}
categoryAuthories_14 = %CategoriesAuthories{categoryID: category_2.id, authorID: author_2.id}

source_1 =
  %Source{
    name: "name---",
    categories_authores: categoryAuthories_1.id,
    title: "title",
    description: "ksdjfkdsjfkds",
    url: "wwwwww",
    urlToImage: "fkjsahfsdjdshf",
    content: "kjsadflkjsdfjsdjf"
  }
  |> Repo.insert!()
