defprotocol ExlasticSearch.Indexable do
  @moduledoc """
  Protocol for converting Ecto structs to ES-compatible maps.  `ExlasticSearch.Repo` uses
  this internally to effect any conversion prior to communicating with elasticsearch itself
  """

  @doc "ES record id"
  @spec id(struct) :: binary
  def id(_)

  @doc "Properties map to be inserted into ES"
  @spec document(struct) :: map
  def document(_)

  @doc "Any preloads needed to call `document/1`"
  @spec preload(struct) :: struct
  def preload(_)
end
