select distinct 
   pd.name as [Package]
 , 'RelationshipType' as [Name]
 , i.name as [Group] 
 , t.keyed_name
 , t.id 
 , t.created_on 
 , isnull(rit.modified_on,rit.created_on)  as modified_on 
  from innovator.ItemType i , 
  innovator.[RELATIONSHIPTYPE] t 
   inner join innovator.PACKAGEELEMENT pe on pe.element_id=t.id 
   inner join innovator.packageGroup pg on pg.id = pe.source_id 
   inner join  innovator.PACKAGEDEFINITION pd on pd.id =pg.source_id 
   inner join innovator.ITEMTYPE rit on rit.ID = t.RELATIONSHIP_ID 
  where i.instance_data = 'RELATIONSHIPTYPE'
     and isnull(rit.modified_on,rit.created_on)  > '@Date' 
     and not isnull(t.modified_on,t.created_on)  > '@Date' 
