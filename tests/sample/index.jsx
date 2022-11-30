const Button = (props) => {
  // result of JOIN (node 'object_pattern')
  const { isDisabled, className, classes, onClick, text, id } = { ...props };
  // result of SPLIT (node 'object_pattern')
  const {
    isDisabled,
    className,
    classes,
    onClick,
    text,
    id,
  } = { ...props };
  // result of JOIN (node 'array')
  const arr = [ 1, 2, 3 ];
  // result of SPLIT (node 'array')
  const arr = [
    1,
    2,
    3,
  ];
  return (
    <div>
      // result of JOIN (node 'jsx_self_closing_element')
      <button onClick={onClick} className='Button' disabled={isDisabled} id={id} />
      // result of SPLIT (node 'jsx_self_closing_element')
      <button
        onClick={onClick}
        className='Button'
        disabled={isDisabled}
        id={id}
      />
      // result of JOIN (node 'jsx_opening_element')
      <button onClick={onClick} className='Button' disabled={isDisabled} id={id}>Button</button>
      // result of SPLIT (node 'jsx_opening_element')
      <button
        onClick={onClick}
        className='Button'
        disabled={isDisabled}
        id={id}
      >Button</button>
      // result of JOIN (node 'jsx_element')
      <button onClick={onClick} className='Button' disabled={isDisabled} id={id}>Button</button>
      // result of SPLIT (node 'jsx_element')
      <button onClick={onClick} className='Button' disabled={isDisabled} id={id}>
        Button
      </button>
      // result of JOIN (node 'jsx_self_closing_element' with last_indent = 'inner')
      <button onClick={onClick} className='Button' disabled={isDisabled} id={id}/>
      // result of SPLIT (node 'jsx_self_closing_element' with last_indent = 'inner')
      <button
        onClick={onClick}
        className='Button'
        disabled={isDisabled}
        id={id}/>

    </div>
  );
};

// result of JOIN (node with 'nested_identifier')
const test = () => {
  return (
    <Skeleton.Button block active />
  );
}

// result of SPLIT (node with 'nested_identifier')
const test = () => {
  return (
    <Skeleton.Button
      block
      active
    />
  );
}
