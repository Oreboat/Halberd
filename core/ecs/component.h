
static struct Archetype
{
    /* data */
};

static struct SparseSet
{
    /* data */
};

typedef union component
{
    Archetype archetype;
    SparseSet sparse_set;
    
} Component;


