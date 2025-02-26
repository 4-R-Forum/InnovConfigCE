 select distinct * from (
 select distinct pd.name as Package
    , i.name
    , isnull(i.label,i.name) as [Group] 
    , t.keyed_name
    , case i.is_versionable when '1' then t.config_id else t.id end as id,
        case i.is_versionable when '1' then (select max(created_on) from innovator.[@TableName] where config_id= t.config_id) else t.created_on end as created_on
    , case i.is_versionable when '1' then (select max(isnull(modified_on,created_on)) from innovator.[@TableName] where config_id= t.config_id) 
        else isnull(t.modified_on,t.created_on) end as modified_on
   from innovator.ItemType i ,
          innovator.[@TableName] t
  inner join innovator.PACKAGEELEMENT pe on pe.element_id=t.id
  inner join innovator.packageGroup pg on pg.id = pe.source_id
  inner join  innovator.PACKAGEDEFINITION pd on pd.id =pg.source_id
  where i.instance_data = '@TableName' 
  and case i.is_versionable when '1' then 
	(select max(isnull(modified_on,created_on)) from innovator.[@TableName] where config_id= t.config_id) 
	else isnull(t.modified_on,t.created_on) end > '@Date'
  and  case when (i.name='ItemType' and i.is_relationship = '1') then 0 else 1 end = 1
 
UNION ALL

select distinct 'x_NOT_in_package' as Package
	, i.name
  , isnull(i.label,i.name)  as [Group] 
	, t.keyed_name
	, case i.is_versionable when '1' then t.config_id else t.id end as id,
		case i.is_versionable when '1' then 
			(select max(created_on) from innovator.[@TableName] where config_id = t.config_id) 
			else t.created_on end as created_on, 
		case i.is_versionable when '1' then (select max(modified_on) from innovator.[@TableName] where config_id= t.config_id) else t.modified_on end as modified_on
from innovator.[@TableName] t, 
	  innovator.itemtype i 
  where i.instance_data = '@TableName' and i.is_relationship <> '1'
  and case i.is_versionable when '1' then (select max(modified_on) from innovator.[@TableName] where config_id= t.config_id) else t.modified_on end > '@Date'
  and case i.is_versionable when '1' then t.config_id else t.id end not in 
  (
  SELECT
    innovator.PACKAGEELEMENT.ELEMENT_ID AS id
  FROM innovator.PACKAGEDEFINITION
    INNER JOIN innovator.PACKAGEGROUP
      ON innovator.PACKAGEDEFINITION.ID = innovator.PACKAGEGROUP.SOURCE_ID
    INNER JOIN innovator.PACKAGEELEMENT
      ON innovator.PACKAGEGROUP.ID = innovator.PACKAGEELEMENT.SOURCE_ID
  )
  and  case when (i.name='ItemType' and i.is_relationship = '1') then 0 else 1 end = 1
  @Exclusions
   ) as data
