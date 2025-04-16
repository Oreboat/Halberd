
static struct Archetype
{
    /* data */
};

static struct SparseSet
{
    int page_size;
    
};

typedef union component
{
    Archetype archetype;
    SparseSet sparse_set;
    
} Component;


