import chromadb

chroma_client = chromadb.HttpClient(host='localhost', port=8000)

collection = chroma_client.get_or_create_collection(name="my_collection")

collection.add(
    documents=[
        "This is a document about pineapple",
        "This is some fake document",
        "This is a document about oranges"
    ],
    ids=["id1", "id2", "id3"]
)
print(f"List of the first 10 items in the collection: {collection.peek()}")
print(f"Number of items in the collection: {collection.count()}")

results = collection.query(
    query_texts=["orange"],
    n_results=1
)
print(f"Query collection results: {results}")

results = collection.get(
	ids=["id2"]
)
print(f"Get document by id: {results}")