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

# Using EX with SET Command

Instead of using the **SETEX** command, we can also use the **SET** command with the **EX** option as shown below.

```
SET mohanad 400 EX 30
```

# PSETEX Command

This command is similar to **SETEX** command. The only difference is that the time provided is in **milliseconds**.

```
PSETEX mohanad 30000 500
```

# Using PX with SET Command

Instead of using the **PSETEX** command, we can also use the **SET** command with the **PX** option as shown below.

# SETNX Command

The **SETNX** command is used if a key is already present. If a key is already present and we run **SET** again, then the value is updated. If we need to avoid this, we can use **SETNX**.

# STRLEN Command

This command is used if we need to find the length of the value for a particular key. The syntax of this command is:

```
STRLEN apple
```

# Redis Commands: MSET and MGET

## MSET command

If we need to save multiple records in a single command, we can use the MSET command. In the example below, we are setting the stock prices of multiple companies in a single command. The syntax of this command is:

    MSET key1 value1 key2 value2

## MGET command

If we need to get the value of multiple keys in a single command, we can use the MGET command. In the example below, we are getting the stock prices of multiple companies in a single command.

    MGET key1 key2


## KEYS command

If we need to find out what keys are stored in Redis, we can use the KEYS command, as shown below. This command will return all the keys saved in the database. The syntax of this command is:

    KEYS *


# INCR Command

We can use this command if we need to increment the value of a given key by 1. In the example below, we are increasing the stock price of Oracle by 1. The syntax of this command is:

    INCR key


# INCRBY Command

We can use this command if we need to increment the value for a given key by a particular number. In the example below, we are increasing the stock price of Oracle by 5. The syntax of this command is:

    INCRBY key count

If the value is not an integer, then either the ERR value is not an integer or out of range error is thrown. If we try to increment a key that does not exist, then a new key with value 1, is created. Similarly, if we try to decrement a key that does not exist then a new key, with value -1, is created.


# INCRBYFLOAT Command

This command is used if we need to increment the value of a key by a floating point number. In the example below, we are incrementing the stock price of Oracle by 3.5. The syntax of this command is:

    INCRBYFLOAT key floatValue




# DECR Command

We can use this command if we need to decrement the value for a given key by 1. In the example below, we are decreasing the stock price of Oracle by 1.

## Example:

    SET oracle_stock 100
    DECR oracle_stock
    GET oracle_stock  # Returns 99


# DECRBY Command

We can use this command if we need to decrement the value for a given key by a particular number. In the example below, we are decreasing the stock price of Oracle by 5.

## Example:

    SET oracle_stock 100
    DECRBY oracle_stock 5
    GET oracle_stock  # Returns 95




# DEL Command

We can use this command to delete a particular key or multiple keys from Redis. In the example below, we are deleting the Oracle key.

## Example:

    SET oracle_stock 100
    DEL oracle_stock
    GET oracle_stock  # Returns (nil)


# FLUSHALL Command

We can flush all the keys present in Redis using this command, as shown below.

## Example:

    SET key1 value1
    SET key2 value2
    FLUSHALL
    GET key1  # Returns (nil)
    GET key2  # Returns (nil)


# APPEND Command

If we need to append some string to a value, we can use the APPEND command. In the example below, we created a key for which the value is "hello". We used APPEND to append "world" to the value.

## Example:

    SET greeting "hello"
    APPEND greeting " world"
    GET greeting  # Returns "hello world"


# Storing Lists in Redis: Insertion Commands

Let’s look at the commands used to insert Lists in the Redis database.

As well as storing Strings in Redis, we can also store Lists. The Redis database internally stores Lists as a linked list. This linked list has a head and tail. Whenever we insert a new element, we can insert it either at the head or tail. The ‘head’ of the list is considered as the left-most element of the list, and the ‘tail’ is considered as the right-most element of the list.

Let’s look at some of the commands that are used to handle Lists in the Redis database. We need to store a list of all the companies that build cars. We will store the list in a key called `cars`. If a new company arrives, then it is added to the list. If a company stops producing cars, then it is removed from the list. We are going to maintain this list in Redis.

## LPUSH command

The `LPUSH` command is used to insert a value at the head of the list. We can provide one or more values with this command. The syntax of this command is:

    LPUSH key value...

In the example below, we are inserting car manufacturers into the Redis database. The key is `cars`. We have inserted four manufacturers.

## Example:

    LPUSH cars "Toyota"
    LPUSH cars "Ford"
    LPUSH cars "BMW"
    LPUSH cars "Tesla"
    LRANGE cars 0 -1  # Returns ["Tesla", "BMW", "Ford", "Toyota"]

Please note that the elements are inserted in reverse order. The reason for this is that each element is picked and inserted at the head.

## LRANGE command

The `LRANGE` command is used to see what elements are present for a given key. Suppose a key contains a List with a million records as its value. We might not want to see all the elements. We may only want to see the first three elements. The `LRANGE` command takes the start and end index as input, which is used to specify which elements from the list are displayed.

    LRANGE key start end

In the example below, we are displaying the first three elements from the list.

## Example:

    LRANGE cars 0 2  # Returns ["Tesla", "BMW", "Ford"]

If we are not aware of the elements count, then we can provide `-1` in the end index. The following command will show all the elements in the list:

    LRANGE cars 0 -1

## LPOP command

The `LPOP` command is used to remove an element from the list. This command removes the element at the head, i.e., the left of the list.

    LPOP key

In the example below, when we run `LPOP`, then Tesla will be removed because it is at the head.

## Example:

    LPOP cars  # Removes "Tesla"
    LRANGE cars 0 -1  # Returns ["BMW", "Ford", "Toyota"]

## RPUSH command

The `RPUSH` command is used to insert a value at the tail of the list. The syntax of this command is below. We can provide one or more values with this command.

    RPUSH key value...

In the example below, we are inserting the car manufacturers into the Redis database. The key is `cars`. We have inserted four manufacturers.

## Example:

    RPUSH cars "Honda"
    RPUSH cars "Mercedes"
    LRANGE cars 0 -1  # Returns ["BMW", "Ford", "Toyota", "Honda", "Mercedes"]

## RPOP command

The `RPOP` command is used to remove the element from the tail of the list.

    RPOP key

## Example:

    RPOP cars  # Removes "Mercedes"
    LRANGE cars 0 -1  # Returns ["BMW", "Ford", "Toyota", "Honda"]



# Modifying Lists in Redis

We will look at how we can modify a List present in the database.

## LLEN command

The `LLEN` command is used to find the length of the list, as shown below.

### Syntax:

    LLEN key

### Example:

In the example below, we are finding the length of the list stored in the Redis database.

    RPUSH cars "Toyota"
    RPUSH cars "Ford"
    RPUSH cars "BMW"
    RPUSH cars "Tesla"
    
    LLEN cars  # Returns 4

## LINDEX command

The `LINDEX` command is used to find the element at a particular index in the list.

### Syntax:

    LINDEX key index

### Example:

In the example below, we are retrieving the element at index `2` from the list stored in the Redis database.

    LINDEX cars 2  # Returns "BMW"

## LSET command

The `LSET` command is used to update the value at a given index.

### Syntax:

    LSET key index value

### Example:

In the example below, we have `BMW` at index `0`. We will change it to `Mercedes` using the `LSET` command.

    LSET cars 0 "Mercedes"

## LPUSHX command

The `LPUSHX` command adds an element to the head of the list if the list exists.

### Syntax:

    LPUSHX key value

### Example:

If the key `cars` exists, we add `Honda` to the head of the list.

    LPUSHX cars "Honda"

## LINSERT command

The `LINSERT` command is useful if we need to insert an element before a particular element in a list.

### Syntax:

    LINSERT key BEFORE|AFTER pivot value

### Example:

Let’s say we need to add the first ten natural numbers in a list. We added them but forgot to add number `6`, as shown below:

    RPUSH numbers 1 2 3 4 5 7 8 9 10
    
We can insert `6` before `7` using `LINSERT`:

    LINSERT numbers BEFORE 7 6
    
Now the list will be:

    LRANGE numbers 0 -1  # Returns 1 2 3 4 5 6 7 8 9 10



# Working with Sets in Redis

## SADD command

To add an element into a set in Redis, we use the `SADD` command.

### Syntax:

    SADD key value

### Example:

In the example below, we are adding the fruits to Redis.

    SADD fruits "apple"
    SADD fruits "banana"
    SADD fruits "orange"

Now we will try to add `apple` again to the set. We will receive `0` as the output of the `SADD` command, which means the fruit was not added.

    SADD fruits "apple"  # Returns 0

## SMEMBERS command

To see all the elements in a set, we can use the `SMEMBERS` command.

### Syntax:

    SMEMBERS key

### Example:

To retrieve all the elements in the `fruits` set:

    SMEMBERS fruits  # Returns "apple", "banana", "orange"

## SISMEMBER command

To check if an element is present in a set, we can use the `SISMEMBER` command. If the element is present in the set, then `1` will be returned. Otherwise, `0` will be returned.

### Syntax:

    SISMEMBER key value

### Example:

To check if `banana` is in the `fruits` set:

    SISMEMBER fruits "banana"  # Returns 1

To check if `grape` is in the `fruits` set:

    SISMEMBER fruits "grape"  # Returns 0

## SCARD command

The `SCARD` command is used to find the count of members present in the set.

### Syntax:

    SCARD key

### Example:

To find the number of elements in the `fruits` set:

    SCARD fruits  # Returns 3

## SDIFF command

The `SDIFF` command is used to find the difference between two sets.

### Syntax:

    SDIFF key1 key2

### Example:

Suppose we have two sets, `S1` and `S2`. The difference, `S1 - S2`, returns all elements that are present in `S1` but not in `S2`.

    SADD set1 "apple" "banana" "cherry"
    SADD set2 "banana" "cherry" "date"
    SDIFF set1 set2  # Returns "apple"


SUNION command

As the name suggests, the SUNION command is used to find the union of two or more sets.

    SUNION key1 key2 key3

SREM command

If we need to remove some elements from the set, then we can use SREM command.

    SREM key value1 value2 …

In the example below, we are removing apple from our fruits set. When the command is executed, 1 is returned, which indicates that one fruit was removed.

SPOP command

This command is used to remove a random value from the set. We can remove one or more random values.

    SPOP key count

SMOVE command

The SMOVE command is used to move a value from one set to another.

Currently, we have two sets, i.e., fruits and fruits1. The elements in each of these sets are shown below.

We will move the fruit from one set to another using the SMOVE command.

    SMOVE source dest member



ZADD command#

This command is used to add elements to the sorted set in the Redis database. Here is the syntax of this command:

    ZADD key score value …

The same element cannot be inserted twice in a sorted set as all the elements are unique. But it is possible to add multiple different elements having the same score. When multiple elements have the same score, they are ordered lexicographically.

ZRANGE command

This command is for fetching all the elements for a particular key. If we need to fetch all the elements in the sorted set, we can provide -1 in the end field as shown below.

    ZRANGE key start end

ZRANGEBYSCORE command

This command is for fetching the elements in a particular range of scores.

    ZRANGEBYSCORE key start end

ZCARD command

To get the number of elements in the sorted set, ZCARD is used. The syntax of this command is:

    ZCARD key

ZCOUNT command

This command is used to find the number of elements within a certain range of scores. Let’s say we need to find all the countries where the freedom of speech index is less than 100.

    ZCOUNT key min max


ZREM command

The ZREM command is used to remove a member from the sorted set. The syntax of this command is:

    ZREM key value

ZRANK command

The ZRANK command is used to find the index of an element in the sorted set. If the rank of an element is 0, then its score is the lowest. The syntax of this command is:

    ZRANK key member

ZREVRANK command

The ZREVRANK command is used to find the rank from the reverse. If the rank of an element is 0, then the score is the highest. The syntax of this command is:

    ZREVRANK key member

ZSCORE command

To get the score of an element, use the ZSCORE command. The syntax of this command is:

    ZSCORE key member
