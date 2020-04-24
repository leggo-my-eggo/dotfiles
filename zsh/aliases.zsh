alias reload!='. ~/.zshrc'

alias cls='clear' # Good 'ol Clear Screen command

dbc_all ()
{
    app="oars";
    environment=$2;
    cmd=$3;
    cmd_args=${@:4};
    domain_args="";    
    region="us-west-2";
    regex="\"([a-z]{2,5}-[a-z]{2,5})-$app-config-$environment\"";
    sdb_domains=$(dbconf -R $region -a $app -e $environment ls);
    for sdb_domain in ${(f)sdb_domains};
    do
        if [[ $sdb_domain =~ $regex ]]; then
            domain="${BASH_REMATCH[1]}";
            domain_args="$domain_args -d $domain";
        fi;
    done;

    dbconf -R $region -a $app $domain_args -e $environment $cmd $cmd_args;
}