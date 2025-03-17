# What is Redis?

Redis stands for **REmote DIctionary Server**. It was written in C by *Salvatore Sanfilippo* in 2006. It is a **NoSQL advanced key-value data store**. The read and write operations are very fast in Redis because it stores all data in memory. The data can also be stored on the disk and can be written back to the memory.

# Redis Data Types

Learn the various data types that Redis supports.

As we have mentioned earlier, Redis is a key-value store, but that doesn’t mean it stores only string keys and string values. Redis supports different types of data structures as values. The key in Redis is a **binary-safe String**, with a max size of **512 MB**, but you should always consider creating shorter keys.

> A binary-safe string is a string that can contain any kind of data, e.g., a JPEG image or a serialized Java object.

# String

This is the simplest type of value that can be associated with a key in Redis. **Memcached** cache only supports string values. In Redis, we have the advantage of storing both strings and collections of strings as values. A string value cannot exceed **512 MB** of text or binary data. However, it can store any type of data, like text, integers, floats, videos, images, and audio files.

> **Memcached** is also an open-source distributed memory caching system. Like Redis, it also stores data in key-value pairs, but it only supports **String** type data.

Redis String can be used to store **session IDs, static HTML pages, configuration XML, JSON**, etc. It can also be used to work as a **counter** if integers are stored.

# List

If we need to store a collection of strings in Redis, then we can use the **List** type. If we use List in Redis, the elements are stored in a **linked list**. The benefit of this is the quick insertion and removal of the element from the head. If we need to insert an element in a List with **500 records**, then it will take about the same amount of time as adding the element in a list of **50,000 records**.

The downside is that if we need to access an element, the entire list is scanned, and it becomes a time-consuming operation. Since the List uses a linked list, the elements are **sorted on the basis of the insertion order**.

The list should be stored in those cases where **the order of insertion matters** and where **the write speed matters more than the read speed**. One such case is **storing logs**.

# Set

The **Set** value type is similar to **List**. The only difference is that the set **doesn’t allow duplicates**. The elements are **not sorted** in any order.

Set offers **constant time performance** for adding and removing operations. We can use a set to store data where **uniqueness matters**, e.g., storing the **number of unique visitors** on our website.

# Sorted Set

If we need our elements to be sorted, we can use **Sorted Set** as the value type. Each element in the sorted set is associated with a number, called a **score**. The elements are stored in the set based on their score. 

For example, let’s say we have a key called **fruits**. We need to store **apple** and **banana** as values. If the score of **apple** is **10**, and the score of **banana** is **15**, then since **score_apple < score_banana**, the order will be **apple**, followed by **banana**.

If the **score of two elements is the same**, then we check which **String is lexicographically bigger**. The two strings **cannot be the same**, as this is a **Set**.

> **Lexicographic order** is dictionary order, except that all the uppercase letters precede all the lowercase letters.

# Hash

The **Hash** value type is a **field-value pair**. Let’s say we need to store the information about the **marks scored by students**. In this case, the **subject** can be the **key**. The **value** can be a **field-value pair**, where the **field** is the **student name**, and the **value** is the **marks obtained**.

# Storing Strings in Redis: Insertion and Retrieval Commands

Learn about how we can store Strings in Redis.

The simplest form of data that can be stored in the Redis database is **String**. We can store **static HTML pages** in the Redis database where the **key** is some name used to identify the page and **value** is the **HTML String**. 

We will look at all the commands used to store and fetch records from the Redis database when the value type is **String**.

# SET Command

We can store a record in Redis using the **SET** command. The syntax of this command is:

```
SET key value
```

Let’s say we need to save the name of a company and its stock price in Redis. In the example below, we are storing the stock price of **Apple** in Redis. When we execute a command in Redis, **OK** is returned, which means that the command was executed successfully.

```
SET apple 300
```

# GET Command

We can get the stock value of Apple using the **GET** command.

```
GET key
```

Example:

```
GET apple
```

If we run the **SET** command again for **Apple**, with a different value, then the record in Redis is **updated**.

# SETEX Command

This command is used if we need to set a certain time after which the key will be removed from the database. The time provided is in seconds.

```
SETEX key seconds value
```

In the example below, we are storing the stock price for **Microsoft**. We are providing the time as **40 seconds**. When we try to get this key before **40 seconds**, then we get the data. We will try again after **40 seconds**, and the data will not be returned. The two GET commands demonstrate this case.

```
SETEX mohanad 40 500
```

